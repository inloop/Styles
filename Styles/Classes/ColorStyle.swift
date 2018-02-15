//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

public final class ColorStyle: NSObject {
    public enum Property: Equatable {
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

        public static func ==(lhs: Property, rhs: Property) -> Bool {
            switch (lhs, rhs) {
            case (.backgroundColor, .backgroundColor):
                return true
            case (.tintColor, .tintColor):
                return true
            default:
                return false
            }
        }
    }

    let properties: [Property]

    public convenience init(_ properties: Property...) {
        self.init(properties)
    }

    private init(_ properties: [Property]) {
        self.properties = properties
    }

    @objc public func apply(to view: UIView) {
        for property in properties {
            property.apply(to: view)
        }
    }

    public func updating(_ other: Property...) -> ColorStyle {
        return ColorStyle(properties.updating(other))
    }
}
