import Foundation

struct AppEnvironment {
    let apiBaseURL: URL
    let appName: String
    let sentryDSN: String?

    static let current = AppEnvironment(
        apiBaseURL: URL(string: "https://api.example.com")!,
        appName: "PJCiOSApp",
        sentryDSN: nil
    )
}
