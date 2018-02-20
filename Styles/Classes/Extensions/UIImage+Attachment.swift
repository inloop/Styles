//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

extension UIImage {
    func attachmentString(with style: TextStyle, baseAttributes: [NSAttributedStringKey: Any]) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = self
        attachment.bounds = CGRect(origin: .zero, size: size)
        let attachmentString = NSAttributedString(attachment: attachment).mutable()
        // let style override base attributes
        let allAttributes = style.attributes.merging(baseAttributes, uniquingKeysWith: {$1})
        attachmentString.addAttributes(allAttributes, range: NSRange(location: 0, length: attachmentString.length))
        return attachmentString
    }
}
