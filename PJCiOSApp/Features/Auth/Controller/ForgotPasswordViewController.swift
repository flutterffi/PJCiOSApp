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
        title = L10n.Auth.resetPassword
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
            forgotPasswordView.renderFormState(isLoading: false, message: L10n.Auth.forgotPasswordHint)
        case .loading:
            forgotPasswordView.renderFormState(isLoading: true, message: L10n.Auth.forgotPasswordLoading)
        case .sent(let message):
            forgotPasswordView.renderFormState(isLoading: false, message: message)
        case .failed(let message):
            forgotPasswordView.renderFormState(isLoading: false, message: message)
        }
    }

    @objc private func submitTapped() {
        view.endEditing(true)
        viewModel.requestReset(email: forgotPasswordView.emailTextField.text ?? "")
    }
}
