import Alamofire
import Foundation

protocol APIClienting {
    func request<T: Decodable & Sendable>(
        _ endpoint: APIEndpoint,
        completion: @Sendable @escaping (Result<T, NetworkError>) -> Void
    )
}

final class AlamofireAPIClient: APIClienting {
    private let environment: NetworkEnvironment
    private let tokenProvider: AuthorizationTokenProviding?
    private let session: Session
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let logger: AppLogging?

    init(
        environment: NetworkEnvironment,
        tokenProvider: AuthorizationTokenProviding? = nil,
        session: Session = .default,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder(),
        logger: AppLogging? = nil
    ) {
        self.environment = environment
        self.tokenProvider = tokenProvider
        self.session = session
        self.encoder = encoder
        self.decoder = decoder
        self.logger = logger
    }

    func request<T: Decodable & Sendable>(
        _ endpoint: APIEndpoint,
        completion: @Sendable @escaping (Result<T, NetworkError>) -> Void
    ) {
        let request: URLRequest

        do {
            request = try makeURLRequest(endpoint)
        } catch let error as NetworkError {
            completion(.failure(error))
            return
        } catch {
            completion(.failure(.requestEncoding(error.localizedDescription)))
            return
        }

        log(request)

        session.request(request)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self, decoder: decoder) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(NetworkError(error: error, statusCode: response.response?.statusCode)))
            }
        }
    }

    func makeURLRequest(_ endpoint: APIEndpoint) throws -> URLRequest {
        guard var components = URLComponents(
            url: environment.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        ) else {
            throw NetworkError.invalidURL
        }

        if !endpoint.queryItems.isEmpty {
            components.queryItems = endpoint.queryItems
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url, timeoutInterval: environment.timeoutInterval)
        request.httpMethod = endpoint.method.rawValue

        let headers = makeHeaders(for: endpoint)
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let body = endpoint.body {
            request.httpBody = try encoder.encode(AnyEncodable(body))
        }

        return request
    }

    private func makeHeaders(for endpoint: APIEndpoint) -> [String: String] {
        var headers = environment.defaultHeaders
        endpoint.headers.forEach { key, value in
            headers[key] = value
        }

        if endpoint.requiresAuthentication, let token = tokenProvider?.authorizationToken, !token.isEmpty {
            headers["Authorization"] = "Bearer \(token)"
        }

        return headers
    }

    private func log(_ request: URLRequest) {
        guard environment.logsRequests else {
            return
        }

        logger?.info("API \(request.httpMethod ?? "REQUEST") \(request.url?.absoluteString ?? "<invalid-url>")")
    }
}

private struct AnyEncodable: Encodable {
    private let encode: (Encoder) throws -> Void

    init(_ value: Encodable) {
        self.encode = value.encode
    }

    func encode(to encoder: Encoder) throws {
        try encode(encoder)
    }
}
