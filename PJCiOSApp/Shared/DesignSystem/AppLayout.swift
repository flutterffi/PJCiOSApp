import SnapKit
import UIKit

enum AppLayout {
    static let designWidth: CGFloat = 375
    static let designHeight: CGFloat = 812
    static let formMaxWidth: CGFloat = 480
    static let textFieldHeight: CGFloat = 48
    static let buttonMinHeight: CGFloat = 48
    static var screenSize: CGSize { UIScreen.main.bounds.size }
    static var screenWidth: CGFloat { screenSize.width }
    static var screenHeight: CGFloat { screenSize.height }
    static var widthRatio: CGFloat { widthRatio(for: screenWidth) }
    static var heightRatio: CGFloat { heightRatio(for: screenHeight) }
    static var screenAspectRatio: CGFloat { aspectRatio(for: screenSize) }

    static func widthRatio(for width: CGFloat) -> CGFloat {
        guard designWidth > 0 else { return 1 }
        return width / designWidth
    }

    static func heightRatio(for height: CGFloat) -> CGFloat {
        guard designHeight > 0 else { return 1 }
        return height / designHeight
    }

    static func aspectRatio(for size: CGSize) -> CGFloat {
        guard size.height > 0 else { return 0 }
        return size.width / size.height
    }

    static func scaleWidth(_ value: CGFloat, for width: CGFloat = screenWidth) -> CGFloat {
        value * widthRatio(for: width)
    }

    static func scaleHeight(_ value: CGFloat, for height: CGFloat = screenHeight) -> CGFloat {
        value * heightRatio(for: height)
    }

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
