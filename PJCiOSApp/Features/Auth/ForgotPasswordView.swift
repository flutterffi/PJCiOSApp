import SnapKit
import UIKit

final class ForgotPasswordView: UIView {
    let emailTextField = UITextField()
    let submitButton = PrimaryButton(type: .system)
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

        emailTextField.placeholder = "Email"
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.borderStyle = .roundedRect

        submitButton.setTitle("Send Reset Link", for: .normal)

        messageLabel.numberOfLines = 0
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center

        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            submitButton,
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

        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
}
