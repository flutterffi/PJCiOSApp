import SnapKit
import UIKit

final class HomeView: UIView {
    let signOutButton = PrimaryButton(type: .system)

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func render(_ state: HomeViewState) {
        titleLabel.text = state.title
        subtitleLabel.text = state.subtitle
    }

    private func configure() {
        backgroundColor = AppColor.background

        titleLabel.font = AppFont.title
        titleLabel.textColor = AppColor.textPrimary
        titleLabel.numberOfLines = 0

        subtitleLabel.font = AppFont.body
        subtitleLabel.textColor = AppColor.textSecondary
        subtitleLabel.numberOfLines = 0

        signOutButton.setTitle(L10n.Home.signOut, for: .normal)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, signOutButton])
        stackView.axis = .vertical
        stackView.spacing = AppSpacing.medium
        addSubview(stackView)

        AppLayout.pinReadableStack(stackView, in: self)
    }
}
