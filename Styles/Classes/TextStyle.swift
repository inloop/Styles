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
        case strikethrought(TextDecoration)
        case underline(TextDecoration)
        case obliqueness(Double)
        case shadow(NSShadow)

        var attribute: [(NSAttributedStringKey, Any)] {
            switch self {
            case .font(let font):
                return [(.font, font)]
            case .foregroundColor(let color):
                return [(.foregroundColor, color)]
            case .backgroundColor(let color):
                return [(.backgroundColor, color)]
            case .paragraphStyle(let styles):
                let paragraphStyle = NSMutableParagraphStyle()
                styles.forEach(paragraphStyle.apply)
                return [(.paragraphStyle, paragraphStyle)]
            case .letterSpacing(let spacing):
                return [(.kern, spacing)]
            case .strikethrought(let decoration):
                return  decoration.attributes(
                    styleKey: .strikethroughStyle,
                    colorKey: .strikethroughColor
                )
            case .underline(let decoration):
                return decoration.attributes(
                    styleKey: .underlineStyle,
                    colorKey: .underlineColor
                )
            case .obliqueness(let skew):
                return [(.obliqueness, skew)]
            case .shadow(let shadow):
                return [(.shadow, shadow)]
            }
        }
    }

    @objc public let attributes: [NSAttributedStringKey: Any]
    let effects: [TextEffect]

    public init(_ properties: Property..., effects: [TextEffect] = []) {
        attributes = properties.attributes
        self.effects = effects
    }

    private init(attributes: [NSAttributedStringKey: Any], effects: [TextEffect]) {
        self.attributes = attributes
        self.effects = effects
    }

    @objc public func apply(to text: String) -> NSAttributedString {
        let result = NSMutableAttributedString(string: text, attributes: attributes)
        for effect in effects {
            let effectAttributes = effect.attributes
            for range in effect.ranges(in: text) {
                result.addAttributes(effectAttributes, range: range)
            }
        }
        return result
    }

    public func updating(_ properties: Property ...) -> TextStyle {
        let newAttributes = attributes.merging(properties.attributes, uniquingKeysWith: { $1 })
        return TextStyle(attributes: newAttributes, effects: effects)
    }
}
