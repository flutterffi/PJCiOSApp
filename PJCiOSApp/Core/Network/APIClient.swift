import Alamofire
import Foundation

protocol APIClienting {
    func request<T: Decodable>(_ endpoint: APIEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class AlamofireAPIClient: APIClienting {
    private let baseURL: URL
    private let decoder: JSONDecoder

    init(baseURL: URL, decoder: JSONDecoder = JSONDecoder()) {
        self.baseURL = baseURL
        self.decoder = decoder
    }

    func request<T: Decodable>(_ endpoint: APIEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent(endpoint.path)
        AF.request(
            url,
            method: Alamofire.HTTPMethod(rawValue: endpoint.method.rawValue),
            headers: HTTPHeaders(endpoint.headers)
        )
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
}
