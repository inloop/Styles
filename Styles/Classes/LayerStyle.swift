//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

public final class LayerStyle: NSObject {
    public enum Property {
        case borderColor(UIColor)
        case borderWidth(CGFloat)
        case cornerRadius(CGFloat)
        case opacity(Float)

        var attribute: (WritableKeyPathApplicator<CALayer>, Any) {
            switch self {
            case .borderColor(let color):
                return (WritableKeyPathApplicator(\CALayer.borderColor), color.cgColor)
            case .borderWidth(let width):
                return (WritableKeyPathApplicator(\CALayer.borderWidth), width)
            case .cornerRadius(let radius):
                return (WritableKeyPathApplicator(\CALayer.cornerRadius), radius)
            case .opacity(let opacity):
                return (WritableKeyPathApplicator(\CALayer.opacity), opacity)
            }
        }
    }

    let properties: [Property]

    public init(_ properties: Property...) {
        self.properties = properties
    }

    @objc public func apply(to layer: CALayer) {
        properties.map { $0.attribute }.forEach { key, value in
            key.apply(value: value, to: layer)
        }
    }
}
