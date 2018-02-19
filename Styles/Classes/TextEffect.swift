//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

public protocol Match {
    func ranges(in base: String) -> [NSRange]
}

final public class TextEffect: NSObject {
    private let match: Match
    public let attributes: [NSAttributedStringKey: Any]

    public convenience init(style: TextStyle, matching match: Match) {
        self.init(style.attributes, match)
    }

    private init(_ attributes: [NSAttributedStringKey: Any], _ match: Match) {
        self.attributes = attributes
        self.match = match
    }

    public static func image(_ image: UIImage, style: TextStyle, match: Match) -> TextEffect {
        let styleAttributes = style.attributes
        let attachment = NSTextAttachment()
        attachment.image = image
        let attachmentAttributes: [NSAttributedStringKey: Any] = [
            .attachment: NSAttributedString(attachment: attachment)
        ]
        let combinedAttachments = attachmentAttributes.merging(styleAttributes, uniquingKeysWith: { l, r in l })
        return TextEffect(combinedAttachments, match)
    }

    public func apply(to base: NSMutableAttributedString) {
        for range in match.ranges(in: base.string) {
            base.addAttributes(attributes, range: range)
        }
    }
}
