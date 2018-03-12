//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import XCTest
@testable import Styles

final class UITextFieldStylesTests: XCTestCase {
    var textField: UITextField!

    override func setUp() {
        super.setUp()
        textField = UITextField()
    }

    func testInvalidLayerConfiguration() {
        let s1 = ViewStyle(.cornerRadius(3))
        let s2 = ViewStyle(.tintColor(.red))
        textField.setViewStyle(s1, for: .editing)

        XCTAssertThrowsError(try ObjC.catchException({
            self.textField.setViewStyle(s2, for: .inactive)
        }))
    }
}
