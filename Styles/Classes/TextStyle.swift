//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

public extension NSMutableParagraphStyle {
    public func apply(_ style: TextStyle.ParagraphStyle) {
        switch style {
        case let .alignment(textAlignment):
            alignment = textAlignment
        case let .lineHeight(spacing):
            lineSpacing = spacing
        }
    }
}

public final class TextStyle: NSObject {
    public enum ParagraphStyle {
        case alignment(NSTextAlignment)
        case lineHeight(CGFloat)
    }

    public enum Property {
        case font(UIFont)
        case foregroundColor(UIColor)
        case backgroundColor(UIColor)
        case paragraphStyle([ParagraphStyle])
        case letterSpacing(CGFloat)

        var attribute: (NSAttributedStringKey, Any) {
            switch self {
            case let .font(font):
                return (.font, font)
            case let .foregroundColor(color):
                return (.foregroundColor, color)
            case let .backgroundColor(color):
                return (.backgroundColor, color)
            case let .paragraphStyle(styles):
                let paragraphStyle = NSMutableParagraphStyle()
                styles.forEach(paragraphStyle.apply)
                return (.paragraphStyle, paragraphStyle)
            case let .letterSpacing(spacing):
                return (.kern, spacing)
            }
        }
    }

    let properties: [Property]
    
    @objc public var attributes: [NSAttributedStringKey: Any] {
        return Dictionary(uniqueKeysWithValues: properties.map { $0.attribute })
    }

    public init(_ properties: Property...) {
        self.properties = properties
    }

    @objc public func apply(to text: String) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: attributes)
    }
}
