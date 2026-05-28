import UIKit

final class LoginViewController: UIViewController {
    var onAuthenticated: ((UserSession) -> Void)?
    var onRegisterRequested: (() -> Void)?
    var onForgotPasswordRequested: (() -> Void)?

    private let viewModel: LoginViewModel
    private let loginView = LoginView()
    private var stateObservation: UUID?

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureActions()
        bindViewModel()
    }

    override func loadView() {
        view = loginView
    }

    private func configureView() {
        title = "Sign In"
    }

    private func configureActions() {
        loginView.signInButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
    }

    private func bindViewModel() {
        stateObservation = viewModel.state.bind { [weak self] state in
            self?.render(state)
        }
    }

    private func render(_ state: LoginViewModel.State) {
        switch state {
        case .idle:
            setLoading(false)
            loginView.messageLabel.text = "Use demo@pjcios.app and password for the local mock server."
        case .loading:
            setLoading(true)
            loginView.messageLabel.text = "Signing in..."
        case .authenticated(let session):
            setLoading(false)
            onAuthenticated?(session)
        case .failed(let message):
            setLoading(false)
            loginView.messageLabel.text = message
        }
    }

    private func setLoading(_ isLoading: Bool) {
        loginView.signInButton.isEnabled = !isLoading
        loginView.registerButton.isEnabled = !isLoading
        loginView.forgotPasswordButton.isEnabled = !isLoading

        if isLoading {
            loginView.activityIndicator.startAnimating()
        } else {
            loginView.activityIndicator.stopAnimating()
        }
    }

    @objc private func loginTapped() {
        view.endEditing(true)
        viewModel.login(email: loginView.emailTextField.text ?? "", password: loginView.passwordTextField.text ?? "")
    }

    @objc private func registerTapped() {
        onRegisterRequested?()
    }

    @objc private func forgotPasswordTapped() {
        onForgotPasswordRequested?()
    }
}
