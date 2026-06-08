import UIKit

final class HomeViewController: UIViewController {
    var onSignedOut: (() -> Void)?

    private let viewModel: HomeViewModel
    private let homeView = HomeView()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        render()
    }

    override func loadView() {
        view = homeView
    }

    private func configureView() {
        title = L10n.Home.title
        homeView.signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
    }

    private func render() {
        homeView.render(viewModel.state)
    }

    @objc private func signOutTapped() {
        viewModel.signOut()
        onSignedOut?()
    }
}
