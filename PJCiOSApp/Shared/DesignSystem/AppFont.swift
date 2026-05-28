import UIKit

enum AppFont {
    static var title: UIFont {
        UIFontMetrics(forTextStyle: .title1).scaledFont(for: .systemFont(ofSize: 28, weight: .bold))
    }

    static var body: UIFont {
        UIFontMetrics(forTextStyle: .body).scaledFont(for: .systemFont(ofSize: 17))
    }

    static var callout: UIFont {
        UIFontMetrics(forTextStyle: .callout).scaledFont(for: .systemFont(ofSize: 16))
    }

    static var footnote: UIFont {
        UIFontMetrics(forTextStyle: .footnote).scaledFont(for: .systemFont(ofSize: 14))
    }
}
