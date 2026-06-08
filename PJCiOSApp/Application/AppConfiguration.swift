import Foundation

struct AppConfiguration: Equatable {
    let networkEnvironmentName: NetworkEnvironmentName
    let networkBaseURL: URL?
    let appName: String
    let sentryDSN: String?

    static let current = AppConfiguration(
        launchArguments: ProcessInfo.processInfo.arguments,
        environmentVariables: ProcessInfo.processInfo.environment,
        infoDictionary: Bundle.main.infoDictionary
    )

    init(
        launchArguments: [String],
        environmentVariables: [String: String],
        infoDictionary: [String: Any]?
    ) {
        self.networkEnvironmentName = Self.resolveEnvironmentName(
            launchArguments: launchArguments,
            environmentVariables: environmentVariables,
            infoDictionary: infoDictionary
        )
        self.networkBaseURL = Self.resolveURL(
            key: Key.networkBaseURL,
            launchArguments: launchArguments,
            environmentVariables: environmentVariables,
            infoDictionary: infoDictionary
        )
        self.appName = Self.resolveString(
            key: Key.appName,
            launchArguments: launchArguments,
            environmentVariables: environmentVariables,
            infoDictionary: infoDictionary
        ) ?? "PJCiOSApp"
        self.sentryDSN = Self.resolveString(
            key: Key.sentryDSN,
            launchArguments: launchArguments,
            environmentVariables: environmentVariables,
            infoDictionary: infoDictionary
        )
    }

    var networkEnvironment: NetworkEnvironment {
        let baseEnvironment = NetworkEnvironment.make(networkEnvironmentName)

        guard let networkBaseURL else {
            return baseEnvironment
        }

        return NetworkEnvironment(
            name: baseEnvironment.name,
            baseURL: networkBaseURL,
            defaultHeaders: baseEnvironment.defaultHeaders,
            timeoutInterval: baseEnvironment.timeoutInterval,
            logsRequests: baseEnvironment.logsRequests
        )
    }
}

private extension AppConfiguration {
    enum Key {
        static let networkEnvironment = "PJCIOS_NETWORK_ENVIRONMENT"
        static let networkBaseURL = "PJCIOS_NETWORK_BASE_URL"
        static let appName = "PJCIOS_APP_NAME"
        static let sentryDSN = "PJCIOS_SENTRY_DSN"
    }

    static func resolveEnvironmentName(
        launchArguments: [String],
        environmentVariables: [String: String],
        infoDictionary: [String: Any]?
    ) -> NetworkEnvironmentName {
        let rawValue = resolveString(
            key: Key.networkEnvironment,
            launchArguments: launchArguments,
            environmentVariables: environmentVariables,
            infoDictionary: infoDictionary
        )

        return rawValue
            .map { NetworkEnvironmentName(rawValue: $0.lowercased()) }
            .flatMap { $0 } ?? .local
    }

    static func resolveURL(
        key: String,
        launchArguments: [String],
        environmentVariables: [String: String],
        infoDictionary: [String: Any]?
    ) -> URL? {
        resolveString(
            key: key,
            launchArguments: launchArguments,
            environmentVariables: environmentVariables,
            infoDictionary: infoDictionary
        ).flatMap(URL.init(string:))
    }

    static func resolveString(
        key: String,
        launchArguments: [String],
        environmentVariables: [String: String],
        infoDictionary: [String: Any]?
    ) -> String? {
        launchArgumentValue(for: key, in: launchArguments)
            ?? environmentVariables[key]
            ?? infoDictionary?[key] as? String
    }

    static func launchArgumentValue(for key: String, in launchArguments: [String]) -> String? {
        let assignmentPrefix = "--\(key)="
        if let assignment = launchArguments.first(where: { $0.hasPrefix(assignmentPrefix) }) {
            return String(assignment.dropFirst(assignmentPrefix.count))
        }

        guard let keyIndex = launchArguments.firstIndex(of: "-\(key)") else {
            return nil
        }

        let valueIndex = launchArguments.index(after: keyIndex)
        guard launchArguments.indices.contains(valueIndex) else {
            return nil
        }

        return launchArguments[valueIndex]
    }
}
