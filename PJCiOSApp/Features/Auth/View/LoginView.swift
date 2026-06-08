import SnapKit
import UIKit

final class LoginView: UIView {
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = PrimaryButton(type: .system)
    let registerButton = UIButton(type: .system)
    let forgotPasswordButton = UIButton(type: .system)
    let messageLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        backgroundColor = AppColor.background

        emailTextField.placeholder = L10n.Auth.emailPlaceholder
        emailTextField.textContentType = .username
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        AppTextFieldStyle.apply(to: emailTextField)

        passwordTextField.placeholder = L10n.Auth.passwordPlaceholder
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        AppTextFieldStyle.apply(to: passwordTextField)

        signInButton.setTitle(L10n.Auth.signIn, for: .normal)
        registerButton.setTitle(L10n.Auth.createAccount, for: .normal)
        forgotPasswordButton.setTitle(L10n.Auth.forgotPassword, for: .normal)

        messageLabel.numberOfLines = 0
        messageLabel.font = AppFont.footnote
        messageLabel.textColor = AppColor.textSecondary
        messageLabel.textAlignment = .center

        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordTextField,
            signInButton,
            registerButton,
            forgotPasswordButton,
            activityIndicator,
            messageLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = AppSpacing.large
        addSubview(stackView)

        AppLayout.pinFormStack(stackView, in: self)

        [emailTextField, passwordTextField].forEach { textField in
            textField.snp.makeConstraints { make in
                make.height.equalTo(AppLayout.textFieldHeight)
            }
        }
    }
}
