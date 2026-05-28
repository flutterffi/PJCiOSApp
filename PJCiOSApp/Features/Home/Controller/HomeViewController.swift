import SnapKit
import UIKit

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

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
        configureLayout()
        render()
    }

    private func configureView() {
        title = "Home"
        view.backgroundColor = AppColor.background
        titleLabel.font = AppFont.title
        titleLabel.textColor = AppColor.textPrimary
        titleLabel.numberOfLines = 0
        subtitleLabel.font = AppFont.body
        subtitleLabel.textColor = AppColor.textSecondary
        subtitleLabel.numberOfLines = 0
    }

    private func configureLayout() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = AppSpacing.medium
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        AppLayout.pinReadableStack(stackView, in: view)
    }

    private func render() {
        titleLabel.text = viewModel.state.title
        subtitleLabel.text = viewModel.state.subtitle
    }
}
