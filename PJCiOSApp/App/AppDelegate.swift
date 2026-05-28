import Sentry
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    private let environment = AppEnvironment.current

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configureSentry()
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    private func configureSentry() {
        guard let dsn = environment.sentryDSN, !dsn.isEmpty else {
            return
        }

        SentrySDK.start { options in
            options.dsn = dsn
            options.tracesSampleRate = 0.2
            options.environment = "development"
        }
    }
}
