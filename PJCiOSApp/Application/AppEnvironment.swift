import Foundation

struct AppEnvironment {
    let apiBaseURL: URL
    let appName: String

    static let current = AppEnvironment(
        apiBaseURL: URL(string: "https://api.example.com")!,
        appName: "PJCiOSApp"
    )
}
