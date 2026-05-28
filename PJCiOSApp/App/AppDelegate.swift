import UIKit
import Sentry

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private let container = AppContainer(environment: .current)
    private var coordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configureSentry()

        let window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = AppCoordinator(window: window, container: container)
        self.window = window
        self.coordinator = coordinator
        coordinator.start()
        return true
    }

    private func configureSentry() {
        guard let dsn = container.environment.sentryDSN, !dsn.isEmpty else {
            return
        }

        SentrySDK.start { options in
            options.dsn = dsn
            options.tracesSampleRate = 0.2
            options.environment = "development"
        }
    }
}
