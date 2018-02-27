//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import XCTest
@testable import Styles

final class TextStyleTests: XCTestCase {
    func testFont() {
        let expected = UIFont.systemFont(ofSize: 12)
        let style = TextStyle(.font(expected))

        let actual = style.attributes[.font] as? UIFont

        XCTAssertNotNil(actual)
        XCTAssertEqual(actual, expected)
    }

    func testForegroundColor() {
        let style = TextStyle(.foregroundColor(.red))

        let actual = style.attributes[.foregroundColor] as? UIColor

        XCTAssertNotNil(actual)
        XCTAssertEqual(actual, .red)
    }

    func testBackgroundColor() {
        let style = TextStyle(.backgroundColor(.red))

        let actual = style.attributes[.backgroundColor] as? UIColor

        XCTAssertNotNil(actual)
        XCTAssertEqual(actual, .red)
    }

    func testParagraphStyle() {
        let style = TextStyle(.paragraphStyle([.alignment(.center), .lineHeight(104)]))
        let actual = style.attributes[.paragraphStyle] as? NSParagraphStyle

        XCTAssertNotNil(actual)
        XCTAssertEqual(actual?.alignment, .center)
        XCTAssertEqual(actual?.lineSpacing, 104)
    }

    func testLetterSpacing() {
        let style = TextStyle(.letterSpacing(104))
        let actual = style.attributes[.kern] as? CGFloat

        XCTAssertNotNil(actual)
        XCTAssertEqual(actual, CGFloat(104))
    }

    func testStrikethrought() {
        _testDecoration(styleKey: .strikethroughStyle, colorKey: .strikethroughColor)
    }

    func testUnderline() {
        _testDecoration(styleKey: .underlineStyle, colorKey: .underlineColor)
    }

    func _testDecoration(styleKey: NSAttributedStringKey, colorKey: NSAttributedStringKey) {
        let expected = TextDecoration(style: .thick, pattern: .dashDotDot, byWord: true, color: .red)
        let property: TextStyle.Property
        if styleKey == .strikethroughStyle {
            property = .strikethrought(expected)
        } else {
            property = .underline(expected)
        }
        let style = TextStyle(property)
        let actualStyle = style.attributes[styleKey] as? Int
        let actualColor = style.attributes[colorKey] as? UIColor

        XCTAssertNotNil(actualStyle)
        XCTAssertEqual(actualStyle, expected.value)

        XCTAssertNotNil(actualColor)
        XCTAssertEqual(actualColor, expected.color)
    }

    func testObliqueness() {
        let style = TextStyle(.obliqueness(104))
        let actual = style.attributes[.obliqueness] as? Double

        XCTAssertNotNil(actual)
        XCTAssertEqual(actual, 104.0)
    }

    func testShadow() {
        let expected = NSShadow()
        expected.shadowColor = UIColor.red
        expected.shadowOffset = CGSize(width: 10, height: 4)
        expected.shadowBlurRadius = 10.4
        let style = TextStyle(.shadow(expected))
        let actual = style.attributes[.shadow] as? NSShadow

        XCTAssertNotNil(actual)
        XCTAssertEqual(actual, expected)
    }

    func testWritingDirectionOverrides() {
        let overrides = [
            TextStyle.WritingDirectionOverride.leftToRightOverride
        ]
        let expected = overrides.map { $0.rawValue }
        let style = TextStyle(.writingDirectionOverrides(overrides))
        let actual = style.attributes[.writingDirection] as? [Int]

        XCTAssertNotNil(actual)
        XCTAssertEqual(actual!, expected)
    }

    func testBaselineOffset() {
        let style = TextStyle(.baselineOffset(10.4))
        let actual = style.attributes[.baselineOffset] as? Double

        XCTAssertNotNil(actual)
        XCTAssertEqual(actual, 10.4)
    }

    func testCombining() {
        let style = TextStyle(.baselineOffset(10.4)) + TextStyle(.backgroundColor(.red))
        let actualColor = style.attributes[.backgroundColor] as? UIColor
        let actualOffset = style.attributes[.baselineOffset] as? Double

        XCTAssertNotNil(actualColor)
        XCTAssertNotNil(actualOffset)
        XCTAssertEqual(actualColor, .red)
        XCTAssertEqual(actualOffset, 10.4)
    }

    func testUpdating() {
        let style = TextStyle(.baselineOffset(10.3)).updating(.baselineOffset(10.4))
        let actual = style.attributes[.baselineOffset] as? Double

        XCTAssertNotNil(actual)
        XCTAssertEqual(actual, 10.4)
    }
}
