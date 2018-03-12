//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

extension UIOffset {
    var size: CGSize {
        return CGSize(width: horizontal, height: vertical)
    }

    public static let zero = UIOffset(horizontal: 0, vertical: 0)
}

public struct Shadow {
    public let color: UIColor
    public let opacity: Float
    public let offset: UIOffset
    public let radius: CGFloat
    public let shouldRasterizeLayer: Bool
    public let rasterizationScale: CGFloat

    public init(color: UIColor, offset: UIOffset, radius: CGFloat, opacity: Float = 1, shouldRasterizeLayer: Bool = true, rasterizationScale: CGFloat = UIScreen.main.scale) {
        self.color = color
        self.opacity = opacity
        self.offset = offset
        self.radius = radius
        self.shouldRasterizeLayer = shouldRasterizeLayer
        self.rasterizationScale = rasterizationScale
    }

    func apply(to layer: CALayer) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset.size
        layer.shadowRadius = radius
        layer.shouldRasterize = shouldRasterizeLayer
        layer.rasterizationScale = rasterizationScale
    }

    var nsShadow: NSShadow {
        let shadow = NSShadow()
        shadow.shadowColor = color
        shadow.shadowOffset = offset.size
        shadow.shadowBlurRadius = radius
        return shadow
    }
}

extension Shadow {
    public static let none = Shadow(
        color: .black,
        offset: UIOffset(horizontal: 0, vertical: -3),
        radius: 3,
        opacity: 0,
        shouldRasterizeLayer: false,
        rasterizationScale: 1.0
    )
}
