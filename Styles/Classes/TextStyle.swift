//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

/**
 Define a TextStyle using `TextStyle.Property` array.

 **Note**
 If you set the view style on given UI element it simply takes the text
 assigned to it and tranforms it into `NSAttributedString` applying
 the array of `TextStyle.Property`.

 It can represent the style of:
 - UITextView
 - UILabel
 - UITextField

 **Example**
 ```swift
 @IBOutlet weak var label: UILabel!

 let redColor = TextStyle(.foregroundColor(.red))
 label.textStyle = style
 ```
 */
public final class TextStyle: NSObject {
    /**
     Defines a style of an paragraph.
     Can define `NSTextAlignment` by `.alignment` and `.lineSpacing`
     */
    public enum ParagraphStyle {
        /// The text alignment of the receiver.
        case alignment(NSTextAlignment)
        /// The distance in points between the bottom of one line fragment and the top of the next.
        case lineSpacing(CGFloat)
        /// The space after the end of the paragraph.
        case paragraphSpacing(CGFloat)
    }

    /**
     Overrides the writing direction. For more reference
     @see NSAttributedStringKey.writingDirection
     */
    public enum WritingDirectionOverride: Int {
        /// Embeds left to right direction override
        case leftToRightEmbedding
        /// Embeds right to left direction override
        case rightToLeftEmbedding
        /// Overrides left to right direction override
        case leftToRightOverride
        /// Overrides right to left direction override
        case rightToLeftOverride
    }

    /**
     Property enumerates the options available for `TextStyle`. You can pick from
     [.font, foregroundColor, .backgroundColor,
     .paragraphStyle, .letterSpacing, .strikethrought,
     .underline, .obliqueness, .shadow,
     .writingDirectionOverrides, .baselineOffset].

     @see `ParagraphStyle`, `TextDecoration`, `Shadow`, `WritingDirectionOverride`
     */
    public enum Property {
        /// Specifies `UIFont`
        case font(UIFont)
        /// Specifies the text color
        case foregroundColor(UIColor)
        /// Specifies the text backgroundColor
        case backgroundColor(UIColor)
        /// Spcifies the text `ParagraphStyle`
        case paragraphStyle([ParagraphStyle])
        /// Specifies letter spacing
        case letterSpacing(CGFloat)
        /// Specifies the `TextDecoration` of strikethrought
        case strikethrought(TextDecoration)
        /// Specifies the `TextDecoration` of underline
        case underline(TextDecoration)
        /// Specifies the obliqueness of the text
        case obliqueness(Double)
        /// Specifies the text `Shadow`
        case shadow(Shadow)
        /// Specifies array of `WritingDirectionOverride`
        case writingDirectionOverrides([WritingDirectionOverride])
        /// Specifies baseline offset
        case baselineOffset(Double)

        var attribute: [(NSAttributedString.Key, Any)] {
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
                return [(.shadow, shadow.nsShadow)]
            case .writingDirectionOverrides(let overrides):
                let rawValues = overrides.map { $0.rawValue }
                return [(.writingDirection, rawValues)]
            case .baselineOffset(let offset):
                return [(.baselineOffset, offset)]
            }
        }
    }

    /// The array of NSAttributedStringKey which are created from `TextStyle.Property` array specified during init
    @objc public let attributes: [NSAttributedString.Key: Any]
    let effects: [TextEffect]

    /**
     Designated initializer of `TextStyle`
     - Parameter properties: The array of properties defining the style
     - Parameter effects: The array of effects that should be applied to style.
     - Returns: New instance of TextStyle
     @see `TextStyle.Property`, `TextEffect`
     */
    public init(_ properties: Property..., effects: [TextEffect] = []) {
        attributes = properties.attributes
        self.effects = effects
    }

    private init(attributes: [NSAttributedString.Key: Any], effects: [TextEffect]) {
        self.attributes = attributes
        self.effects = effects
    }

    /**
     An empty TextStyle having no properties and effects
     */
    public static let empty = TextStyle(attributes: [:], effects: [])

    /**
     Applies self to given text by creating `NSAttributedString` using `attributes`
     - Parameter text: The string to apply style on it
     - Returns: `NSAttributedString` on which are the `attributes` and the effects applied
     */
    @objc public func apply(to text: String) -> NSAttributedString {
        let result = NSMutableAttributedString(string: text, attributes: attributes)
        for effect in effects {
            effect.apply(to: result, baseAttributes: attributes)
        }
        return result
    }

    // MARK:- Combining Styles

    /**
     Updates curent style with given properties. It uses right associativity rule thus if you redefine any of the original properties assigned to self it will ve overwritten by the new one

     - Parameter properties: The array of `Property` to be added to the style
     - Returns: The instance of `TextStyle` with combined properties

     ```swift
     let redText = TextStyle(.foregroundColor(.red))
     let redTextAndBackground = redText.updating(.backgroundColor(.red))
     ```
     */
    public func updating(_ properties: Property...) -> TextStyle {
        let newAttributes = attributes.merging(properties.attributes, uniquingKeysWith: { $1 })
        return TextStyle(attributes: newAttributes, effects: effects)
    }

    /**
     Operator `+` combines two styles. It uses right associativity rule thus if both styles match any property the right will be used.
     - Parameter left: The `TextStyle` to be combined with `right`
     - Parameter right: The `TextStyle` to be combined with `left`
     - Returns: The resulting `TextStyle` containing bot properties from `left` and `right`
     */
    public static func +(left: TextStyle, right: TextStyle) -> TextStyle {
        let newAttributes = left.attributes.merging(right.attributes, uniquingKeysWith: { $1 })
        let newEffects = left.effects.updating(right.effects)
        return TextStyle(attributes: newAttributes, effects: newEffects)
    }

    // MARK:- Updating effects

    /**
     Appends text effects to the current style. It uses right associativity rule thus if current style defines any effect contained in updating it will be overriden and newly defined one will be used.

     - Parameter other: An array of `TextEffect`
     - Returns: The `TextStyle` containing original and newly defined effects
     */
    public func appending(_ other: TextEffect...) -> TextStyle {
        return TextStyle(attributes: attributes, effects: effects.updating(other))
    }

    /**
     Appends text effect to the current style. It uses right associativity rule thus if current style defines an effect matching the updating one it will be overriden and newly defined one will be used.

     - Parameter other: A `TextEffect`
     - Returns: The `TextStyle` containing original effects and newly defined one
     */
    public func appending(_ other: TextEffect) -> TextStyle {
        return TextStyle(attributes: attributes, effects: effects.updating([other]))
    }

    /**
     Removes text effects from the current style.

     - Parameter other: An array of `TextEffect`
     - Returns: The `TextStyle` containing original effects without specified ones
     */
    public func removing(_ other: TextEffect...) -> TextStyle {
        return TextStyle(attributes: attributes, effects: effects.not(in: other))
    }

    /**
     Removes text effect from the current style.

     - Parameter other: A `TextEffect`
     - Returns: The `TextStyle` containing original effects without specified one
     */
    public func removing(_ other: TextEffect) -> TextStyle {
        return TextStyle(attributes: attributes, effects: effects.not(in: [other]))
    }
}
