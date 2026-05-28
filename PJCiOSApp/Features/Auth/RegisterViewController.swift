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
        title = "Create Account"
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
            setLoading(false)
            registerView.messageLabel.text = "Create a local mock account."
        case .loading:
            setLoading(true)
            registerView.messageLabel.text = "Creating account..."
        case .registered(let session):
            setLoading(false)
            onRegistered?(session)
        case .failed(let message):
            setLoading(false)
            registerView.messageLabel.text = message
        }
    }

    private func setLoading(_ isLoading: Bool) {
        registerView.registerButton.isEnabled = !isLoading

        if isLoading {
            registerView.activityIndicator.startAnimating()
        } else {
            registerView.activityIndicator.stopAnimating()
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
