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
        view.backgroundColor = .systemBackground
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.numberOfLines = 0
        subtitleLabel.font = .systemFont(ofSize: 17)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
    }

    private func configureLayout() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
    }

    private func render() {
        titleLabel.text = viewModel.state.title
        subtitleLabel.text = viewModel.state.subtitle
    }
}
