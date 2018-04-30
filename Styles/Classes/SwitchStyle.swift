//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

public final class SwitchStyle: NSObject {
    public enum Property: Equatable {
        case onTintColor(UIColor)
        case tintColor(UIColor)
        case thumbTintColor(UIColor)
        case onImage(UIImage)
        case offImage(UIImage)

        func apply(to uiSwitch: UISwitch) {
            switch self {
            case .onTintColor(let color):
                uiSwitch.onTintColor = color
            case .tintColor(let color):
                uiSwitch.tintColor = color
            case .thumbTintColor(let color):
                uiSwitch.thumbTintColor = color
            case .onImage(let image):
                uiSwitch.onImage = image
            case .offImage(let image):
                uiSwitch.offImage = image
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

    @objc public func apply(to uiSwitch: UISwitch) {
        for property in properties {
            property.apply(to: uiSwitch)
        }
    }

    public func updating(_ other: Property...) -> SwitchStyle {
        return SwitchStyle(properties.updating(other))
    }

    public static func +(left: SwitchStyle, right: SwitchStyle) -> SwitchStyle {
        return SwitchStyle(left.properties.updating(right.properties))
    }
}
