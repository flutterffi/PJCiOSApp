import UIKit

enum AppColor {
    static var background: UIColor { .systemBackground }
    static var groupedBackground: UIColor { .secondarySystemBackground }
    static var primary: UIColor { AppAsset.accentColor.color }
    static var textPrimary: UIColor { .label }
    static var textSecondary: UIColor { .secondaryLabel }
    static var fieldBackground: UIColor { .secondarySystemBackground }
    static var fieldBorder: UIColor { .separator }

    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        UIColor(
            red: normalizedColorComponent(red),
            green: normalizedColorComponent(green),
            blue: normalizedColorComponent(blue),
            alpha: normalizedAlphaComponent(alpha)
        )
    }

    static func hex(_ value: String, alpha overrideAlpha: CGFloat? = nil) -> UIColor? {
        let normalizedValue = value
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
            .replacingOccurrences(of: "0x", with: "", options: .caseInsensitive)

        let expandedValue: String
        switch normalizedValue.count {
        case 3:
            expandedValue = normalizedValue.map { "\($0)\($0)" }.joined()
        case 4:
            expandedValue = normalizedValue.map { "\($0)\($0)" }.joined()
        case 6, 8:
            expandedValue = normalizedValue
        default:
            return nil
        }

        guard let hexNumber = UInt64(expandedValue, radix: 16) else {
            return nil
        }

        let red: UInt64
        let green: UInt64
        let blue: UInt64
        let alpha: UInt64

        if expandedValue.count == 8 {
            alpha = (hexNumber & 0xFF000000) >> 24
            red = (hexNumber & 0x00FF0000) >> 16
            green = (hexNumber & 0x0000FF00) >> 8
            blue = hexNumber & 0x000000FF
        } else {
            alpha = 255
            red = (hexNumber & 0xFF0000) >> 16
            green = (hexNumber & 0x00FF00) >> 8
            blue = hexNumber & 0x0000FF
        }

        return rgb(
            CGFloat(red),
            CGFloat(green),
            CGFloat(blue),
            alpha: overrideAlpha ?? CGFloat(alpha) / 255
        )
    }

    private static func normalizedColorComponent(_ value: CGFloat) -> CGFloat {
        min(max(value, 0), 255) / 255
    }

    private static func normalizedAlphaComponent(_ value: CGFloat) -> CGFloat {
        min(max(value, 0), 1)
    }
}
