//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

/**
 TextDecoration represents either underline or strikethrough of TextStyle properties.
 @see `TextStyle.Property`
*/
public struct TextDecoration {
    /**
     Represents style of the text decoration
     * .single
     * .thick
     * .double
    */
    public enum Style: Int {
        /// Single line
        case single
        /// Single thick line
        case thick
        /// Double line
        case double

        /**
         Raw intepretation of style representing according `NSUnderlineStyle`.
         @see `NSUnderlineStyle.style.rawValue`
        */
        public var rawValue: Int {
            switch self {
            case .single: return NSUnderlineStyle.styleSingle.rawValue
            case .thick: return NSUnderlineStyle.styleThick.rawValue
            case .double: return NSUnderlineStyle.styleDouble.rawValue
            }
        }
    }

    /**
     Represents pattern of the decoration
     * .dot
     * .dash
     * .dashDot
     * .dashDotDot
    */
    public enum Pattern: Int {
        /// Solid pattern
        case solid
        /// Dotted pattern
        case dot
        /// Dashed pattern
        case dash
        /// Dash dotted pattern
        case dashDot
        /// One dash two dots pattern
        case dashDotDot

        /**
         Raw intepretation of style representing according `NSUnderlineStyle`.
         @see `NSUnderlineStyle.pattern.rawValue`
        */
        public var rawValue: Int {
            switch self {
            case .solid: return NSUnderlineStyle.patternSolid.rawValue
            case .dot: return NSUnderlineStyle.patternDot.rawValue
            case .dash: return NSUnderlineStyle.patternDash.rawValue
            case .dashDot: return NSUnderlineStyle.patternDashDot.rawValue
            case .dashDotDot: return NSUnderlineStyle.patternDashDotDot.rawValue
            }
        }
    }

    let style: Style
    let pattern: Pattern
    let byWord: Bool
    let color: UIColor?

    /**
     Designated initializer for TextDecoration

     - Parameter style: Style of the decoration @see `Style`
     - Parameter pattern: The pattern of the decoration @see `Pattern`
     - Parameter byWord: Should be applied by word? *Default value* = `false`
     - Parameter color: Color of the decoration. *Default value* = `nil`
     - Returns: New instance of TextDecoration
    */
    public init(style: Style, pattern: Pattern, byWord: Bool = false, color: UIColor? = nil) {
        self.style = style
        self.pattern = pattern
        self.byWord = byWord
        self.color = color
    }

    var value: Int {
        let byWordValue = byWord ? NSUnderlineStyle.byWord.rawValue : 0
        return style.rawValue | pattern.rawValue | byWordValue
    }

    func attributes(styleKey: NSAttributedStringKey, colorKey: NSAttributedStringKey) -> [(NSAttributedStringKey, Any)] {
        var attributes = [(NSAttributedStringKey, Any)]()
        attributes.append((styleKey, value))
        // bug in ios
        // https://goo.gl/214Xz7
        if let color = color { 
            attributes.append((colorKey, color))
        }
        return attributes
    }
}
