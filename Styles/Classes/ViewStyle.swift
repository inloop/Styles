//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

public final class ViewStyle: NSObject {
    public enum Property: Equatable {
        case backgroundColor(UIColor?)
        case tintColor(UIColor?)
        case borderColor(UIColor)
        case borderWidth(CGFloat)
        case cornerRadius(CGFloat)
        case opacity(Float)

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
            }
        }

        var isLayout: Bool {
            switch self {
            case .backgroundColor:
                return false
            case .tintColor:
                return false
            case .borderColor:
                return false
            case .borderWidth:
                return false
            case .cornerRadius:
                return true
            case .opacity:
                return false
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
            }
        }

        public static func ==(lhs: Property, rhs: Property) -> Bool {
            switch (lhs, rhs) {
            case (.backgroundColor, .backgroundColor),
                 (.tintColor, .tintColor),
                 (.borderColor, .borderColor),
                 (.borderWidth, .borderWidth),
                 (.cornerRadius, .cornerRadius),
                 (.opacity, .opacity):
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

    @objc public func applyLayout(to view: UIView) {
        for property in properties {
            guard property.isLayout else { continue }
            property.apply(to: view)
        }
    }

    public func updating(_ other: Property...) -> ViewStyle {
        return ViewStyle(properties.updating(other))
    }

    public static func +(left: ViewStyle, right: ViewStyle) -> ViewStyle {
        return ViewStyle(left.properties.updating(right.properties))
    }

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
        }
    }
}
