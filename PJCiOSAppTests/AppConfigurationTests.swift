@testable import PJCiOSApp
import XCTest

final class AppConfigurationTests: XCTestCase {
    func testLaunchArgumentsOverrideEnvironmentVariablesAndInfoDictionary() {
        let configuration = AppConfiguration(
            launchArguments: [
                "PJCiOSApp",
                "-PJCIOS_NETWORK_ENVIRONMENT",
                "staging",
                "--PJCIOS_NETWORK_BASE_URL=https://launch.example.com"
            ],
            environmentVariables: [
                "PJCIOS_NETWORK_ENVIRONMENT": "development",
                "PJCIOS_NETWORK_BASE_URL": "https://env.example.com"
            ],
            infoDictionary: [
                "PJCIOS_NETWORK_ENVIRONMENT": "production",
                "PJCIOS_NETWORK_BASE_URL": "https://info.example.com"
            ]
        )

        XCTAssertEqual(configuration.networkEnvironmentName, .staging)
        XCTAssertEqual(configuration.networkEnvironment.baseURL.absoluteString, "https://launch.example.com")
    }

    func testEnvironmentVariablesOverrideInfoDictionary() {
        let configuration = AppConfiguration(
            launchArguments: ["PJCiOSApp"],
            environmentVariables: [
                "PJCIOS_NETWORK_ENVIRONMENT": "production",
                "PJCIOS_APP_NAME": "EnvApp",
                "PJCIOS_SENTRY_DSN": "https://example@sentry.io/1"
            ],
            infoDictionary: [
                "PJCIOS_NETWORK_ENVIRONMENT": "development",
                "PJCIOS_APP_NAME": "InfoApp"
            ]
        )

        XCTAssertEqual(configuration.networkEnvironmentName, .production)
        XCTAssertEqual(configuration.appName, "EnvApp")
        XCTAssertEqual(configuration.sentryDSN, "https://example@sentry.io/1")
    }

    func testInvalidEnvironmentFallsBackToLocal() {
        let configuration = AppConfiguration(
            launchArguments: ["PJCiOSApp"],
            environmentVariables: ["PJCIOS_NETWORK_ENVIRONMENT": "invalid"],
            infoDictionary: nil
        )

        XCTAssertEqual(configuration.networkEnvironmentName, .local)
        XCTAssertEqual(configuration.networkEnvironment, .local)
    }
}
