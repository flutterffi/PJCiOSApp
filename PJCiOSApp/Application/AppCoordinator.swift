import UIKit

@MainActor
final class AppCoordinator {
    private let window: UIWindow
    private let container: AppContainer
    private let navigationController = UINavigationController()

    init(window: UIWindow, container: AppContainer) {
        self.window = window
        self.container = container
    }

    func start() {
        AppNavigationStyle.apply(to: navigationController)
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
        viewController.onRegisterRequested = { [weak self] in
            self?.showRegister()
        }
        viewController.onForgotPasswordRequested = { [weak self] in
            self?.showForgotPassword()
        }
        navigationController.setViewControllers([viewController], animated: false)
    }

    private func showRegister() {
        let viewModel = container.makeRegisterViewModel()
        let viewController = RegisterViewController(viewModel: viewModel)
        viewController.onRegistered = { [weak self] session in
            self?.showHome(session: session)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showForgotPassword() {
        let viewModel = container.makeForgotPasswordViewModel()
        let viewController = ForgotPasswordViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showHome(session: UserSession) {
        let viewModel = container.makeHomeViewModel(session: session)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}
