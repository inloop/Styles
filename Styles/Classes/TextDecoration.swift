//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

public struct TextDecoration {
    public enum Style: Int {
        case single
        case thick
        case double

        public var rawValue: Int {
            switch self {
            case .single: return NSUnderlineStyle.styleSingle.rawValue
            case .thick: return NSUnderlineStyle.styleThick.rawValue
            case .double: return NSUnderlineStyle.styleDouble.rawValue
            }
        }
    }

    public enum Pattern: Int {
        case dot
        case dash
        case dashDot
        case dashDotDot

        public var rawValue: Int {
            switch self {
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
