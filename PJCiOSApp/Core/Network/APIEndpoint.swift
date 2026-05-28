import Foundation

protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
    var requiresAuthentication: Bool { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

extension APIEndpoint {
    var queryItems: [URLQueryItem] {
        []
    }

    var headers: [String: String] {
        [:]
    }

    var body: Encodable? {
        nil
    }

    var requiresAuthentication: Bool {
        true
    }
}
