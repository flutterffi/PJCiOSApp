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
        backgroundColor = .systemBackground

        nameTextField.placeholder = "Name"
        nameTextField.textContentType = .name
        nameTextField.borderStyle = .roundedRect

        emailTextField.placeholder = "Email"
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.borderStyle = .roundedRect

        passwordTextField.placeholder = "Password"
        passwordTextField.textContentType = .newPassword
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect

        registerButton.setTitle("Create Account", for: .normal)

        messageLabel.numberOfLines = 0
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .secondaryLabel
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
        stackView.spacing = 16
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }

        [nameTextField, emailTextField, passwordTextField].forEach { textField in
            textField.snp.makeConstraints { make in
                make.height.equalTo(44)
            }
        }
    }
}
