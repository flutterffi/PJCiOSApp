import Alamofire
import Foundation

enum NetworkError: LocalizedError, Sendable {
    case invalidURL
    case requestEncoding(String)
    case transport(String)
    case invalidResponse
    case server(statusCode: Int)
    case emptyData
    case decoding(String)

    init(error: AFError, statusCode: Int?) {
        if let statusCode, !(200..<300).contains(statusCode) {
            self = .server(statusCode: statusCode)
            return
        }

        if case .responseSerializationFailed = error {
            self = .decoding(error.localizedDescription)
        } else {
            self = .transport(error.localizedDescription)
        }
    }

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid request URL."
        case .requestEncoding(let message):
            return "Failed to encode request: \(message)"
        case .transport(let message):
            return message
        case .invalidResponse:
            return "Invalid server response."
        case .server(let statusCode):
            return "Server returned status code \(statusCode)."
        case .emptyData:
            return "Server returned empty data."
        case .decoding(let message):
            return "Failed to decode response: \(message)"
        }
    }
}
