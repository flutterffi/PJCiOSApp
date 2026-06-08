import Foundation

struct AppEnvironment {
    let network: NetworkEnvironment
    let appName: String
    let sentryDSN: String?

    static let current = AppEnvironment(configuration: .current)

    init(configuration: AppConfiguration) {
        self.network = configuration.networkEnvironment
        self.appName = configuration.appName
        self.sentryDSN = configuration.sentryDSN
    }

    init(network: NetworkEnvironment, appName: String, sentryDSN: String?) {
        self.network = network
        self.appName = appName
        self.sentryDSN = sentryDSN
    }
}
