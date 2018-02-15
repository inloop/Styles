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
public final class LayerStyle: NSObject {
    public enum Property: Equatable {
        case borderColor(UIColor)
        case borderWidth(CGFloat)
        case roundCorners(UIRectCorner, radius: CGFloat)
        case opacity(Float)

        func apply(to view: UIView) {
            switch self {
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
            case (.borderColor, .borderColor):
                return true
            case (.borderWidth, .borderWidth):
                return true
            case (.roundCorners, .roundCorners):
                return true
            case (.opacity, .opacity):
                return true
            default: return false
            }
        }

        static var defaultValues: [Property] {
            return [
                borderColor(.black),
                borderWidth(0),
                roundCorners(.allCorners, radius: 0),
                opacity(1)
            ]
        }
    }

    let properties: [Property]

    public convenience init(_ properties: Property...) {
        self.init(properties)
    }

    private init(_ properties: [Property]) {
        let defaultValues = Property.defaultValues.diff(properties)
        self.properties = properties + defaultValues
    }

    @objc public func apply(to view: UIView) {
        for property in properties {
            property.apply(to: view)
        }
    }

    public func updating(_ other: Property...) -> LayerStyle {
        return LayerStyle(properties.updating(other))
    }
}
