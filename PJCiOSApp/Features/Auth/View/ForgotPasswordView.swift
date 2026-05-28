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
        backgroundColor = AppColor.background

        emailTextField.placeholder = "Email"
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        AppTextFieldStyle.apply(to: emailTextField)

        submitButton.setTitle("Send Reset Link", for: .normal)

        messageLabel.numberOfLines = 0
        messageLabel.font = AppFont.footnote
        messageLabel.textColor = AppColor.textSecondary
        messageLabel.textAlignment = .center

        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            submitButton,
            activityIndicator,
            messageLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = AppSpacing.large
        addSubview(stackView)

        AppLayout.pinFormStack(stackView, in: self)

        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(AppLayout.textFieldHeight)
        }
    }
}
