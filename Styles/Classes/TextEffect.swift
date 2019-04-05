//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

/**
 `Match` represents protocol that should match any word, regular expression or ranges in given string.
 @see `First`, `Regex`, `Block`
 */
public protocol Match: NSObjectProtocol {
    /**
     Finds ranges in base string

     - Parameter base: The string in which to lookup
     - Returns: An array of `NSRange` objects
     */
    func ranges(in base: String) -> [NSRange]
}

/**
 `TextEffect represents any effect added to any `Match`.
 You can represent the effect by `.style` or by `.image`
 */
public enum TextEffect {
    /**
     Represents an effect which applies given `textStyle` to `match`
     */
    case style(TextStyle, Match)
    /**
     Represents an effect which applies `image` and `textStyle` to `match`
     */
    case image(UIImage, TextStyle, Match)
    /**
     Adds a link styled with `textStyle` to `match`
    */
    case link(URL, TextStyle, Match)

    /**
     Creates a new instance of `TextEffect` of case `.style`
     - Parameter style: The text style to be applied to given `Match`
     - Parameter matching: The match for which is the `TextStyle` used
     - Returns: New instance of `TextEffect`
     */
    public init(style: TextStyle, matching match: Match) {
        self = .style(style, match)
    }

    /**
     Creates a new instance of `TextEffect` of case `.image`
     - Parameter image: The image which should be applied for given `Match`
     - Parameter style: The text style to be applied to given `Match`. *Default value* is `TextStyle.empty`
     - Parameter matching: The match for which is the `TextStyle` used
     - Returns: New instance of `TextEffect`
     */
    public init(image: UIImage, style: TextStyle = .empty, matching match: Match) {
        self = .image(image, style, match)
    }

    /**
     Creates a new instance of `TextEffect` of case `.link`
     - Parameter url: The URL which should be applied for given `Match`
     - Parameter style: The text style to be applied to given `Match`. *Default value* is `TextStyle.empty`
     - Parameter matching: The match for which is the `TextStyle` used
     - Returns: New instance of `TextEffect`
     */
    public init(url: URL, style: TextStyle = .empty, matching match: Match) {
        self = .link(url, style, match)
    }

    public var match: Match {
        switch self {
        case .style(_, let match):
            return match
        case .image(_, _, let match):
            return match
        case .link(_, _, let match):
            return match
        }
    }

    public var style: TextStyle {
        switch self {
        case .style(let style, _):
            return style
        case .image(_, let style, _):
            return style
        case .link(_, let style, _):
            return style
        }
    }

    var isLink: Bool {
        if case .link = self {
            return true
        }
        return false
    }

    func apply(to base: NSMutableAttributedString, baseAttributes: [NSAttributedString.Key: Any]) {
        let apply: (NSRange) -> ()
        switch self {
        case .style(let style, _):
            apply = { base.addAttributes(style.attributes, range: $0) }
        case .image(let image, let style, _):
            let imageString = image.attachmentString(with: style, baseAttributes: baseAttributes)
            apply = { base.insert(imageString, at: $0.location) }
        case .link(let url, let style, _):
            var attributes = style.attributes.merging(baseAttributes, uniquingKeysWith: { $1 })
            attributes[.link] = url.absoluteString
            apply = { base.addAttributes(attributes, range: $0)}

        }
        match.ranges(in: base.string).forEach(apply)
    }
}

extension TextEffect: Equatable {
    public static func ==(lhs: TextEffect, rhs: TextEffect) -> Bool {
        switch (lhs, rhs) {
        case (.style(let lStyle, let lMatch), .style(let rStyle, let rMatch)):
            return lStyle == rStyle && lMatch.isEqual(rMatch)
        case (.image(let lImage, let lStyle, let lMatch), .image(let rImage, let rStyle, let rMatch)):
            return lImage == rImage && lStyle == rStyle && lMatch.isEqual(rMatch)
        case (.link(let lURL, let lStyle, let lMatch), .link(let rURL, let rStyle, let rMatch)):
            return lURL == rURL && lStyle == rStyle && lMatch.isEqual(rMatch)
        default: return false
        }
    }
}
