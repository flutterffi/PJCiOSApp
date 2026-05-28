import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let container: AppContainer
    private let navigationController = UINavigationController()

    init(window: UIWindow, container: AppContainer) {
        self.window = window
        self.container = container
    }

    func start() {
        showLogin()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func showLogin() {
        let viewModel = container.makeLoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        viewController.onAuthenticated = { [weak self] session in
            self?.showHome(session: session)
        }
        navigationController.setViewControllers([viewController], animated: false)
    }

    private func showHome(session: UserSession) {
        let viewModel = container.makeHomeViewModel(session: session)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}
