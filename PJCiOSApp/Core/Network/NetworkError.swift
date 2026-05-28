import Alamofire
import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case requestEncoding(Error)
    case transport(Error)
    case invalidResponse
    case server(statusCode: Int)
    case emptyData
    case decoding(Error)

    init(error: AFError, statusCode: Int?) {
        if let statusCode, !(200..<300).contains(statusCode) {
            self = .server(statusCode: statusCode)
            return
        }

        if case .responseSerializationFailed = error {
            self = .decoding(error)
        } else {
            self = .transport(error)
        }
    }

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid request URL."
        case .requestEncoding(let error):
            return "Failed to encode request: \(error.localizedDescription)"
        case .transport(let error):
            return error.localizedDescription
        case .invalidResponse:
            return "Invalid server response."
        case .server(let statusCode):
            return "Server returned status code \(statusCode)."
        case .emptyData:
            return "Server returned empty data."
        case .decoding(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}
