//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

/**
 The `ViewStyle` defines style of any `UIView`.
 Can define color, tint, border, shadow and layer properties.
 @see `ViewStyle.Property`
 */
public final class ViewStyle: NSObject {
    /**
     Property enumerates available options to define the ViewStyle.
     Available options are [.backgroundColor, .tintColor, .borderColor,
     .borderWidth, .cornerRadius, .opacity, .shadow].
     @see `Shadow`
     */
    public enum Property: Equatable {
        /// Specifies optional background color
        case backgroundColor(UIColor?)
        /// Specifies optional tint color
        case tintColor(UIColor?)
        /// Specifies border color
        case borderColor(UIColor)
        /// Specifies width of the border
        case borderWidth(CGFloat)
        /// Specifies corner radius
        case cornerRadius(CGFloat)
        /// Specifies opacity
        case opacity(Float)
        /// Specifies shadow. @see `Shadow`
        case shadow(Shadow)

        func apply(to view: UIView) {
            switch self {
            case .backgroundColor(let color):
                view.backgroundColor = color
            case .tintColor(let color):
                view.tintColor = color
            case .borderColor(let color):
                view.layer.borderColor = color.cgColor
            case .borderWidth(let width):
                view.layer.borderWidth = width
            case .cornerRadius(let radius):
                view.clipsToBounds = true
                view.layer.cornerRadius = radius
            case .opacity(let opacity):
                view.layer.opacity = opacity
            case .shadow(let shadow):
                shadow.apply(to: view.layer)
            }
        }

        var isLayerProperty: Bool {
            switch self {
            case .backgroundColor:
                return false
            case .tintColor:
                return false
            case .borderColor:
                return true
            case .borderWidth:
                return true
            case .cornerRadius:
                return true
            case .opacity:
                return true
            case .shadow:
                return true
            }
        }

        public static func ==(lhs: Property, rhs: Property) -> Bool {
            switch (lhs, rhs) {
            case (.backgroundColor, .backgroundColor),
                 (.tintColor, .tintColor),
                 (.borderColor, .borderColor),
                 (.borderWidth, .borderWidth),
                 (.cornerRadius, .cornerRadius),
                 (.opacity, .opacity),
                 (.shadow, .shadow):
                return true
            default:
                return false
            }
        }
    }

    let properties: [Property]

    /**
     Create a new instance of `ViewStyle` using properties

     - Parametes properties: The array of properties
     - Returns: New instance of `ViewStyle`
     */
    public convenience init(_ properties: Property...) {
        self.init(properties)
    }

    private init(_ properties: [Property]) {
        self.properties = properties
    }

    /**
     Applies self to given `UIView`

     - Parameter view: The view on which to apply the style
     */
    @objc public func apply(to view: UIView) {
        for property in properties {
            property.apply(to: view)
        }
    }

    /**
     Updates curent style with given properties. It uses right associativity rule thus if you redefine any of the original properties assigned to self it will ve overwritten by the new one

     - Parameter properties: The array of `Property` to be added to the style
     - Returns: The instance of `ViewStyle` with combined properties

     ```swift
     let red = ViewStyle(.backgroundColor(.red))
     let redTint = red.updating(.tintColor(.red))
     ```
     */
    public func updating(_ other: Property...) -> ViewStyle {
        return ViewStyle(properties.updating(other))
    }

    /**
     Operator `+` combines two styles. It uses right associativity rule thus if both styles match any property the right will be used.
     - Parameter left: The `ViewStyle` to be combined with `right`
     - Parameter right: The `ViewStyle` to be combined with `left`
     - Returns: The resulting `ViewStyle` containing bot properties from `left` and `right`
     */
    public static func +(left: ViewStyle, right: ViewStyle) -> ViewStyle {
        return ViewStyle(left.properties.updating(right.properties))
    }

    /**
     Checks for equality of layer properties.
     If the defined layer properties does not match with otehr style the function throws an error. The layer properties has to match otherwise UI glitches may be created. If the error is thrown it contains a description which properties are missing.
     - Parameter other: The view style to check for equal layer properties
     */
    @objc public func hasEqualLayerProperties(_ other: ViewStyle) throws {
        let filtered = properties.filter { $0.isLayerProperty }
        let otherFiltered = other.properties.filter { $0.isLayerProperty }
        let isSame = filtered == otherFiltered

        if !isSame {
            let diff = filtered.count > otherFiltered.count ? filtered.not(in: otherFiltered) : otherFiltered.not(in: filtered)
            let error = NSError(domain: "com.inloopx.Styles", code: -104, userInfo: [NSLocalizedDescriptionKey: "Missing view properties: \(diff.debugDescription)" ])
            throw error
        }
    }
}

extension ViewStyle.Property: CustomDebugStringConvertible {
    /// Describes the property name for debug purposes
    public var debugDescription: String {
        switch self {
        case .backgroundColor:
            return "backgroundColor"
        case .tintColor:
            return "tintColor"
        case .borderColor:
            return "borderColor"
        case .borderWidth:
            return "borderWidth"
        case .cornerRadius:
            return "roundCorners"
        case .opacity:
            return "opacity"
        case .shadow:
            return "shadow"
        }
    }
}
