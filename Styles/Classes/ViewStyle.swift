//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

extension UIRectCorner {
    @available(iOS 11.0, *)
    var maskedCorners: CACornerMask {
        var mask: CACornerMask = []
        if contains(.topLeft) {
            mask.formUnion(CACornerMask.layerMinXMinYCorner)
        }
        if contains(.topRight) {
            mask.formUnion(CACornerMask.layerMaxXMinYCorner)
        }
        if contains(.bottomLeft) {
            mask.formUnion(CACornerMask.layerMinXMaxYCorner)
        }
        if contains(.bottomRight) {
            mask.formUnion(CACornerMask.layerMaxXMaxYCorner)
        }
        if contains(.allCorners) {
            mask = [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
        }
        return mask
    }
}

public final class ViewStyle: NSObject {
    public enum Property: Equatable {
        case backgroundColor(UIColor?)
        case tintColor(UIColor?)
        case borderColor(UIColor)
        case borderWidth(CGFloat)
        case roundCorners(UIRectCorner, radius: CGFloat)
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
            case .roundCorners(let corners, let radius):
                applyRoundCorners(corners, radius: radius, toView: view)
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
            case .roundCorners:
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
            case .roundCorners:
                return true
            case .opacity:
                return true
            }
        }

        private func applyRoundCorners(_ corners: UIRectCorner, radius: CGFloat, toView view: UIView) {
            if #available(iOS 11.0, *) {
                view.clipsToBounds = true
                view.layer.cornerRadius = radius
                view.layer.maskedCorners = corners.maskedCorners
            } else {
                let path = UIBezierPath(
                    roundedRect: view.bounds,
                    byRoundingCorners: corners,
                    cornerRadii: CGSize(width: radius, height: radius)
                )
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                view.layer.mask = mask
            }
        }

        public static func ==(lhs: Property, rhs: Property) -> Bool {
            switch (lhs, rhs) {
            case (.backgroundColor, .backgroundColor),
                 (.tintColor, .tintColor),
                 (.borderColor, .borderColor),
                 (.borderWidth, .borderWidth),
                 (.roundCorners, .roundCorners),
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
        case .roundCorners:
            return "roundCorners"
        case .opacity:
            return "opacity"
        }
    }
}
