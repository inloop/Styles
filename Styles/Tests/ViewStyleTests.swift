//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import XCTest
@testable import Styles

final class ViewStyleTests: XCTestCase {
    let colorStyle = ViewStyle(.backgroundColor(.red))
    let tintStyle = ViewStyle(.tintColor(.blue))
    let borderColorStyle = ViewStyle(.borderColor(.magenta))
    let borderWidthStyle = ViewStyle(.borderWidth(10))
    let opacityStyle = ViewStyle(.opacity(0.3))
    let roundCornersStyle = ViewStyle(.roundCorners(.allCorners, radius: 10))

    var view: UIView!

    override func setUp() {
        super.setUp()
        view = UIView()
    }

    func testBackgoundColor() {
        view.viewStyle = colorStyle

        XCTAssertTrue(view.backgroundColor == .red)
    }

    func testTint() {
        view.viewStyle = tintStyle

        XCTAssertTrue(view.tintColor == .blue)
    }

    func testBorderColor() {
        view.viewStyle = borderColorStyle

        XCTAssertTrue(view.layer.borderColor == UIColor.magenta.cgColor)
    }

    func testBorderWidth() {
        view.viewStyle = borderWidthStyle

        XCTAssertTrue(view.layer.borderWidth == 10)
    }

    func testOpacity() {
        view.viewStyle = opacityStyle

        XCTAssertTrue(view.layer.opacity == 0.3)
    }

    func testCornerRadius() {
        view.viewStyle = roundCornersStyle
        let allCorners = UIRectCorner.allCorners
        let radius: CGFloat = 10

        if #available(iOS 11.0, *) {
            XCTAssertTrue(view.clipsToBounds)
            XCTAssertTrue(view.layer.cornerRadius == radius)
            XCTAssertTrue(view.layer.maskedCorners == allCorners.maskedCorners)
        } else {
            XCTAssertTrue(view.layer.mask != nil)
            let newFrame = CGRect(x: 10, y: 4, width: 10, height: 40)
            view.frame = newFrame
            view.layoutIfNeeded()
            XCTAssertEqual(view.bounds, CGRect(origin: .zero, size: newFrame.size))
            let path = UIBezierPath(
                roundedRect: view.bounds,
                byRoundingCorners: allCorners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let shapeLayer = view.layer.mask as! CAShapeLayer
            XCTAssertEqual(shapeLayer.path?.boundingBox, path.cgPath.boundingBox)
        }
    }

    func testCombining() {
        let combinedStyle = colorStyle + tintStyle
        view.viewStyle = combinedStyle

        XCTAssert(view.backgroundColor == .red)
        XCTAssert(view.tintColor == .blue)
    }

    func testUpdating() {
        let updatedStyle = colorStyle.updating(.backgroundColor(.green))
        view.viewStyle = updatedStyle

        XCTAssert(view.backgroundColor == .green)
    }
}
