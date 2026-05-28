import Foundation

enum NetworkEnvironmentName: String, Sendable {
    case local
    case development
    case staging
    case production
}

struct NetworkEnvironment: Equatable, Sendable {
    let name: NetworkEnvironmentName
    let baseURL: URL
    let defaultHeaders: [String: String]
    let timeoutInterval: TimeInterval
    let logsRequests: Bool

    static let local = NetworkEnvironment(
        name: .local,
        baseURL: URL(string: "http://localhost:3001")!,
        defaultHeaders: Self.defaultJSONHeaders,
        timeoutInterval: 20,
        logsRequests: true
    )

    static let development = NetworkEnvironment(
        name: .development,
        baseURL: URL(string: "https://dev-api.example.com")!,
        defaultHeaders: Self.defaultJSONHeaders,
        timeoutInterval: 20,
        logsRequests: true
    )

    static let staging = NetworkEnvironment(
        name: .staging,
        baseURL: URL(string: "https://staging-api.example.com")!,
        defaultHeaders: Self.defaultJSONHeaders,
        timeoutInterval: 20,
        logsRequests: true
    )

    static let production = NetworkEnvironment(
        name: .production,
        baseURL: URL(string: "https://api.example.com")!,
        defaultHeaders: Self.defaultJSONHeaders,
        timeoutInterval: 20,
        logsRequests: false
    )

    static func make(_ name: NetworkEnvironmentName) -> NetworkEnvironment {
        switch name {
        case .local:
            return .local
        case .development:
            return .development
        case .staging:
            return .staging
        case .production:
            return .production
        }
    }

    private static let defaultJSONHeaders = [
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
}

protocol AuthorizationTokenProviding: Sendable {
    var authorizationToken: String? { get }
}
