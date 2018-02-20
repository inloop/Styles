//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

public protocol Match: NSObjectProtocol {
    func ranges(in base: String) -> [NSRange]
}

public enum TextEffect {
    case style(TextStyle, Match)
    case image(UIImage, TextStyle, Match)

    public init(style: TextStyle, matching match: Match) {
        self = .style(style, match)
    }

    public init(image: UIImage, style: TextStyle = .empty, matching match: Match) {
        self = .image(image, style, match)
    }

    var match: Match {
        switch self {
        case .style(_, let match):
            return match
        case .image(_, _, let match):
            return match
        }
    }

    func apply(to base: NSMutableAttributedString, baseAttributes: [NSAttributedStringKey: Any]) {
        let apply: (NSRange) -> ()
        switch self {
        case .style(let style, _):
            apply = { base.addAttributes(style.attributes, range: $0) }
        case .image(let image, let style, _):
            let imageString = image.attachmentString(with: style, baseAttributes: baseAttributes)
            apply = { base.insert(imageString, at: $0.location) }
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
        default: return false
        }
    }
}
