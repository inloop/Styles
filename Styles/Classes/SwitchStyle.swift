//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

/**
 The `SwitchStyle` defines style of `UISwitch`.
 @see `SwitchStyle.Property`
*/
public final class SwitchStyle: NSObject {
    public enum Property: Equatable {
        /// The color used to tint the appearance of the switch when it is turned on.
        case onTintColor(UIColor)

        /// The color used to tint the outline of the switch when it is turned off.
        case tintColor(UIColor)

        /// The color used to tint the appearance of the thumb.
        case thumbTintColor(UIColor)

        /// The image displayed when the switch is in the on position.
        case onImage(UIImage)

        /// The image displayed when the switch is in the off position.
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

    /**
     Initialize `SwitchStyle` using properties

     - Parametes properties: Comma delimited list of properties
     - Returns: New instance of `SwitchStyle`
     */
    public convenience init(_ properties: Property...) {
        self.init(properties)
    }

    private init(_ properties: [Property]) {
        self.properties = properties
    }

    /**
     Applies properties to `UISwitch`

     - Parameter uiSwitch: The switch on which to apply the style
     */
    @objc public func apply(to uiSwitch: UISwitch) {
        for property in properties {
            property.apply(to: uiSwitch)
        }
    }

    /**
     Updates curent style with given properties. It uses right associativity rule thus if you redefine any of the original properties assigned to self it will ve overwritten by the new one.

     - Parameter properties: The array of `Property` to be added to the style
     - Returns: The instance of `SwitchStyle` with combined properties

     ```swift
     let red = SwitchStyle(.tintColor(.red))
     let onBlue = red.updating(.onTintColor(.blue))
     ```
     */
    public func updating(_ other: Property...) -> SwitchStyle {
        return SwitchStyle(properties.updating(other))
    }

    /**
     Operator `+` combines two styles. It uses right associativity rule thus if both styles match any property the right will be used.
     - Parameter left: The `SwitchStyle` to be combined with `right`
     - Parameter right: The `SwitchStyle` to be combined with `left`
     - Returns: The resulting `SwitchStyle` containing properties from `left` and `right`
     */
    public static func +(left: SwitchStyle, right: SwitchStyle) -> SwitchStyle {
        return SwitchStyle(left.properties.updating(right.properties))
    }
}
