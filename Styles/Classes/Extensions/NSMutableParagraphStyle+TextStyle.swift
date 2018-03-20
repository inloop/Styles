//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

public extension NSMutableParagraphStyle {
    /**
     Applies given `TextStyle.ParagraphStyle` to self
     - Parameter style: The text style of the paragraph
     */
    public func apply(_ style: TextStyle.ParagraphStyle) {
        switch style {
        case let .alignment(textAlignment):
            alignment = textAlignment
        case let .lineSpacing(spacing):
            lineSpacing = spacing
        }
    }
}
