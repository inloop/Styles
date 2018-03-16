//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

extension ViewStyle {
    static let rounded = ViewStyle(
        .cornerRadius(10),
        .borderWidth(3),
        .borderColor(.red),
        .opacity(0.8)
    )

    static let appColor = ViewStyle(
        .backgroundColor(.gray),
        .tintColor(.blue)
    )

    static let redColor = ViewStyle(
        .backgroundColor(.red),
        .shadow(.red)
    )

    static let red = ViewStyle(
        .borderColor(.red),
        .borderWidth(0.5),
        .cornerRadius(0),
        .shadow(.red)
    )

    static let blue = red.updating(
        .borderColor(.blue),
        .cornerRadius(10),
        .shadow(.none)
    )

    static let roundedApp = rounded + appColor
}
