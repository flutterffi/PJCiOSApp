import SnapKit
import UIKit

final class LoginViewController: UIViewController {
    var onAuthenticated: ((UserSession) -> Void)?

    private let viewModel: LoginViewModel
    private var stateObservation: UUID?

    private let stackView = UIStackView()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = PrimaryButton(type: .system)
    private let messageLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

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
        configureFields()
        configureLayout()
        bindViewModel()
    }

    private func configureView() {
        title = "Sign In"
        view.backgroundColor = .systemBackground
    }

    private func configureFields() {
        emailTextField.placeholder = "Email"
        emailTextField.textContentType = .username
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.borderStyle = .roundedRect

        passwordTextField.placeholder = "Password"
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect

        loginButton.setTitle("Sign In", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        messageLabel.numberOfLines = 0
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
    }

    private func configureLayout() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        [emailTextField, passwordTextField, loginButton, activityIndicator, messageLabel].forEach(stackView.addArrangedSubview)
        view.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }

        [emailTextField, passwordTextField].forEach { textField in
            textField.snp.makeConstraints { make in
                make.height.equalTo(44)
            }
        }
    }

    private func bindViewModel() {
        stateObservation = viewModel.state.bind { [weak self] state in
            self?.render(state)
        }
    }

    private func render(_ state: LoginViewModel.State) {
        switch state {
        case .idle:
            loginButton.isEnabled = true
            activityIndicator.stopAnimating()
            messageLabel.text = "Use any valid email and a password with at least 6 characters."
        case .loading:
            loginButton.isEnabled = false
            activityIndicator.startAnimating()
            messageLabel.text = "Signing in..."
        case .authenticated(let session):
            loginButton.isEnabled = true
            activityIndicator.stopAnimating()
            onAuthenticated?(session)
        case .failed(let message):
            loginButton.isEnabled = true
            activityIndicator.stopAnimating()
            messageLabel.text = message
        }
    }

    @objc private func loginTapped() {
        view.endEditing(true)
        viewModel.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}
