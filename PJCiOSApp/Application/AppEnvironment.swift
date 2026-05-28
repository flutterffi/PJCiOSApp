import Foundation

struct AppEnvironment {
    let network: NetworkEnvironment
    let appName: String
    let sentryDSN: String?

    static let current = AppEnvironment(
        network: .development,
        appName: "PJCiOSApp",
        sentryDSN: nil
    )
}
