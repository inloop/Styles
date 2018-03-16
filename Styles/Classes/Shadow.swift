//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

/**
 Structure `Shadow` represents the shadow of the view or text
 */
public struct Shadow {
    /// Shadow color
    public let color: UIColor
    /// Shadow opacity
    public let opacity: Float
    /// Shadow offset
    public let offset: UIOffset
    // Shadow radius
    public let radius: CGFloat
    /// Should the layer be rasterized?
    public let shouldRasterizeLayer: Bool
    /// Rasterization scale - applied only if `shouldRasterizeLayer` is set to `true`
    public let rasterizationScale: CGFloat

    /**
     Designated initializer for shadow

     - Parameter color: The shadow color (UIColor)
     - Parameter offset: The offset color (UIOffset) (horizontal & vertical)
     - Parameter radius: The shadow radius (CGFloat)
     - Parameter opacity: The shadow opacity - default value `CGFloat(1.0)`
     - Parameter shouldRasterizeLayer: Should the layer be rasterized - default value = `true`
     - Parameter rasterizationScale: Rasterization scale - applied only if `shouldRasterizeLayer` is set to `true`, default value= `UIScreen.main.scale`
     - Returns: New instance of `Shadow`
     */
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
    /**
     Represents shadow with black color, vertical offset of -3 and radius of 3

     ```swift
     Shadow(
        color: .black,
        offset: UIOffset(horizontal: 0, vertical: -3),
        radius: 3,
        opacity: 0,
        shouldRasterizeLayer: false,
        rasterizationScale: 1.0
     )
     ```
    */
    public static let none = Shadow(
        color: .black,
        offset: UIOffset(horizontal: 0, vertical: -3),
        radius: 3,
        opacity: 0,
        shouldRasterizeLayer: false,
        rasterizationScale: 1.0
    )
}
