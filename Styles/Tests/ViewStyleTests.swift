//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import XCTest
@testable import Styles

final class UIViewColorStyleTests: XCTestCase {
    let colorStyle = ViewStyle(.backgroundColor(.red))
    let tintStyle = ViewStyle(.tintColor(.blue))
    let borderColorStyle = ViewStyle(.borderColor(.magenta))
    let borderWidthStyle = ViewStyle(.borderWidth(10))
    let opacityStyle = ViewStyle(.opacity(0.3))
    let roundCornersStyle = ViewStyle(.roundCorners(.allCorners, radius: 10))

    func testVeiewHasProperBackgoundColor() {
        let view = UIView()
        XCTAssertTrue(view.backgroundColor == nil)

        view.viewStyle = colorStyle
        XCTAssertTrue(view.backgroundColor != nil)
        XCTAssertTrue(view.backgroundColor == .red)
    }

    func testViewHasTintIfStyleApplied() {
        let view = UIView()
        view.viewStyle = tintStyle

        XCTAssertTrue(view.tintColor == .blue)
    }

    func testHasBorderColorIfStyleApplied() {
        let view = UIView()
        view.viewStyle = borderColorStyle

        XCTAssertTrue(view.layer.borderColor == UIColor.magenta.cgColor)
    }

    func testHasBorderWidthIfStyleApplied() {
        let view = UIView()
        view.viewStyle = borderWidthStyle

        XCTAssertTrue(view.layer.borderWidth == 10)
    }

    func testHasProperOpacityIfStyleApplied() {
        let view = UIView()
        view.viewStyle = opacityStyle

        XCTAssertTrue(view.layer.opacity == 0.3)
    }

    func testHasCornerRadiusesIfStyleApplied() {
        let view = UIView()
        view.viewStyle = roundCornersStyle
        let fullMask: CACornerMask = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
        if #available(iOS 11.0, *) {
            XCTAssertTrue(view.clipsToBounds)
            XCTAssertTrue(view.layer.cornerRadius == 10)
            XCTAssertTrue(view.layer.maskedCorners == fullMask)
        } else {
            XCTAssertTrue(view.layer.mask != nil)
        }
    }
}
