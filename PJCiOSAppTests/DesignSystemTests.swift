@testable import PJCiOSApp
import UIKit
import XCTest

final class DesignSystemTests: XCTestCase {
    func testScreenRatiosUseDesignBaseline() {
        XCTAssertEqual(AppLayout.widthRatio(for: 750), 2)
        XCTAssertEqual(AppLayout.heightRatio(for: 1_624), 2)
        XCTAssertEqual(AppLayout.aspectRatio(for: CGSize(width: 390, height: 844)), 390 / 844, accuracy: 0.0001)
        XCTAssertEqual(AppLayout.scaleWidth(16, for: 750), 32)
        XCTAssertEqual(AppLayout.scaleHeight(24, for: 1_624), 48)
    }

    func testRGBColorUsesZeroTo255Components() {
        let color = AppColor.rgb(255, 128, 0, alpha: 0.5)
        assertColor(color, red: 1, green: 128 / 255, blue: 0, alpha: 0.5)
    }

    func testHexColorSupportsCommonDesignFormats() {
        assertColor(AppColor.hex("#FF8000"), red: 1, green: 128 / 255, blue: 0, alpha: 1)
        assertColor(AppColor.hex("80FF8000"), red: 1, green: 128 / 255, blue: 0, alpha: 128 / 255)
        assertColor(AppColor.hex("#F80"), red: 1, green: 136 / 255, blue: 0, alpha: 1)
        XCTAssertNil(AppColor.hex("invalid"))
    }

    private func assertColor(
        _ color: UIColor?,
        red expectedRed: CGFloat,
        green expectedGreen: CGFloat,
        blue expectedBlue: CGFloat,
        alpha expectedAlpha: CGFloat,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard let color else {
            return XCTFail("Expected color.", file: file, line: line)
        }

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        XCTAssertTrue(color.getRed(&red, green: &green, blue: &blue, alpha: &alpha), file: file, line: line)
        XCTAssertEqual(red, expectedRed, accuracy: 0.0001, file: file, line: line)
        XCTAssertEqual(green, expectedGreen, accuracy: 0.0001, file: file, line: line)
        XCTAssertEqual(blue, expectedBlue, accuracy: 0.0001, file: file, line: line)
        XCTAssertEqual(alpha, expectedAlpha, accuracy: 0.0001, file: file, line: line)
    }
}
