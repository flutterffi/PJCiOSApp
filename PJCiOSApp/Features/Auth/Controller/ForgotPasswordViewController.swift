import UIKit

final class ForgotPasswordViewController: UIViewController {
    private let viewModel: ForgotPasswordViewModel
    private let forgotPasswordView = ForgotPasswordView()
    private var stateObservation: UUID?

    init(viewModel: ForgotPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = forgotPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reset Password"
        forgotPasswordView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        bindViewModel()
    }

    private func bindViewModel() {
        stateObservation = viewModel.state.bind { [weak self] state in
            self?.render(state)
        }
    }

    private func render(_ state: ForgotPasswordViewModel.State) {
        switch state {
        case .idle:
            setLoading(false)
            forgotPasswordView.messageLabel.text = "Enter your email to receive reset instructions."
        case .loading:
            setLoading(true)
            forgotPasswordView.messageLabel.text = "Sending reset instructions..."
        case .sent(let message):
            setLoading(false)
            forgotPasswordView.messageLabel.text = message
        case .failed(let message):
            setLoading(false)
            forgotPasswordView.messageLabel.text = message
        }
    }

    private func setLoading(_ isLoading: Bool) {
        forgotPasswordView.submitButton.isEnabled = !isLoading

        if isLoading {
            forgotPasswordView.activityIndicator.startAnimating()
        } else {
            forgotPasswordView.activityIndicator.stopAnimating()
        }
    }

    @objc private func submitTapped() {
        view.endEditing(true)
        viewModel.requestReset(email: forgotPasswordView.emailTextField.text ?? "")
    }
}
