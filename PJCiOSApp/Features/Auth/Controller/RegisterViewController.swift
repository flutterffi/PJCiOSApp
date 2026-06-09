import UIKit

final class RegisterViewController: UIViewController {
    var onRegistered: ((UserSession) -> Void)?

    private let viewModel: RegisterViewModel
    private let registerView = RegisterView()
    private var stateObservation: UUID?

    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Auth.createAccount
        registerView.registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        bindViewModel()
    }

    private func bindViewModel() {
        stateObservation = viewModel.state.bind { [weak self] state in
            self?.render(state)
        }
    }

    private func render(_ state: RegisterViewModel.State) {
        switch state {
        case .idle:
            registerView.renderFormState(isLoading: false, message: L10n.Auth.registerHint)
        case .loading:
            registerView.renderFormState(isLoading: true, message: L10n.Auth.registerLoading)
        case .registered(let session):
            registerView.renderFormState(isLoading: false, message: "")
            onRegistered?(session)
        case .failed(let message):
            registerView.renderFormState(isLoading: false, message: message)
        }
    }

    @objc private func registerTapped() {
        view.endEditing(true)
        viewModel.register(
            name: registerView.nameTextField.text ?? "",
            email: registerView.emailTextField.text ?? "",
            password: registerView.passwordTextField.text ?? ""
        )
    }
}
