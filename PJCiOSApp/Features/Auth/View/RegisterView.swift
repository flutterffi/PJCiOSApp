import SnapKit
import UIKit

final class RegisterView: UIView {
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let registerButton = PrimaryButton(type: .system)
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

        nameTextField.placeholder = L10n.Auth.namePlaceholder
        nameTextField.textContentType = .name
        AppTextFieldStyle.apply(to: nameTextField)

        emailTextField.placeholder = L10n.Auth.emailPlaceholder
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        AppTextFieldStyle.apply(to: emailTextField)

        passwordTextField.placeholder = L10n.Auth.passwordPlaceholder
        passwordTextField.textContentType = .newPassword
        passwordTextField.isSecureTextEntry = true
        AppTextFieldStyle.apply(to: passwordTextField)

        registerButton.setTitle(L10n.Auth.createAccount, for: .normal)

        messageLabel.numberOfLines = 0
        messageLabel.font = AppFont.footnote
        messageLabel.textColor = AppColor.textSecondary
        messageLabel.textAlignment = .center

        let stackView = UIStackView(arrangedSubviews: [
            nameTextField,
            emailTextField,
            passwordTextField,
            registerButton,
            activityIndicator,
            messageLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = AppSpacing.large
        addSubview(stackView)

        AppLayout.pinFormStack(stackView, in: self)

        [nameTextField, emailTextField, passwordTextField].forEach { textField in
            textField.snp.makeConstraints { make in
                make.height.equalTo(AppLayout.textFieldHeight)
            }
        }
    }
}

extension RegisterView: FormStateRendering {
    var formControls: [UIControl] {
        [registerButton]
    }

    var formMessageLabel: UILabel {
        messageLabel
    }

    var formActivityIndicator: UIActivityIndicatorView {
        activityIndicator
    }
}
