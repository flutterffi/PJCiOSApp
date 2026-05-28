import Foundation

protocol APIClienting {
    func request<T: Decodable>(_ endpoint: APIEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class URLSessionAPIClient: APIClienting {
    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder

    init(baseURL: URL, session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }

    func request<T: Decodable>(_ endpoint: APIEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        session.dataTask(with: request) { [decoder] data, response, error in
            if let error {
                completion(.failure(.transport(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.server(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data else {
                completion(.failure(.emptyData))
                return
            }

            do {
                completion(.success(try decoder.decode(T.self, from: data)))
            } catch {
                completion(.failure(.decoding(error)))
            }
        }.resume()
    }
}
