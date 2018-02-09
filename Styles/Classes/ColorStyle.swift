//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

public final class ColorStyle: NSObject {
    public enum Property {
        case backgroundColor(UIColor)
        case tintColor(UIColor)

        var attribute: (WritableKeyPathApplicator<UIView>, Any) {
            switch self {
            case .backgroundColor(let color):
                return (WritableKeyPathApplicator(\UIView.backgroundColor), color)
            case .tintColor(let color):
                return (WritableKeyPathApplicator(\UIView.tintColor), color)
            }
        }
    }

    let properties: [Property]

    public init(_ properties: Property...) {
        self.properties = properties
    }

    @objc public func apply(to view: UIView) {
        properties.map { $0.attribute }.forEach { key, value in
            key.apply(value: value, to: view)
        }
    }
}
