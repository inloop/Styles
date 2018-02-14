//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

public final class ColorStyle: NSObject {
    public enum Property {
        case backgroundColor(UIColor)
        case tintColor(UIColor)

        func apply(to view: UIView) {
            switch self {
            case .backgroundColor(let color):
                view.backgroundColor = color
            case .tintColor(let color):
                view.tintColor = color
            }
        }
    }

    let properties: [Property]

    public init(_ properties: Property...) {
        self.properties = properties
    }

    @objc public func apply(to view: UIView) {
        for property in properties {
            property.apply(to: view)
        }
    }
}
