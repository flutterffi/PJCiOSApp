import SnapKit
import UIKit

enum AppLayout {
    static let formMaxWidth: CGFloat = 480
    static let textFieldHeight: CGFloat = 48
    static let buttonMinHeight: CGFloat = 48

    static func pinFormStack(_ stackView: UIView, in parentView: UIView) {
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(parentView.safeAreaLayoutGuide)
            make.centerY.equalTo(parentView.safeAreaLayoutGuide)
            make.leading.greaterThanOrEqualTo(parentView.safeAreaLayoutGuide).offset(AppSpacing.screenMargin)
            make.trailing.lessThanOrEqualTo(parentView.safeAreaLayoutGuide).inset(AppSpacing.screenMargin)
            make.width.lessThanOrEqualTo(formMaxWidth)
        }
    }

    static func pinReadableStack(_ stackView: UIView, in parentView: UIView) {
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(parentView.safeAreaLayoutGuide)
            make.centerY.equalTo(parentView.safeAreaLayoutGuide)
            make.leading.greaterThanOrEqualTo(parentView.safeAreaLayoutGuide).offset(AppSpacing.screenMargin)
            make.trailing.lessThanOrEqualTo(parentView.safeAreaLayoutGuide).inset(AppSpacing.screenMargin)
            make.width.lessThanOrEqualTo(formMaxWidth)
        }
    }
}
