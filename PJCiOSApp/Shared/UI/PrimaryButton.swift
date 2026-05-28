import SnapKit
import UIKit

final class PrimaryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        layer.cornerRadius = AppRadius.control
        titleLabel?.font = AppFont.callout.withWeight(.semibold)
        setTitleColor(.white, for: .normal)
        setTitleColor(.white.withAlphaComponent(0.6), for: .disabled)

        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = AppColor.primary
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .medium
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: AppSpacing.medium,
            leading: AppSpacing.large,
            bottom: AppSpacing.medium,
            trailing: AppSpacing.large
        )
        self.configuration = configuration

        snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(AppLayout.buttonMinHeight)
        }
    }

    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.6
        }
    }
}

private extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        .systemFont(ofSize: pointSize, weight: weight)
    }
}
