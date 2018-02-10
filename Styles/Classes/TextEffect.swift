//  Copyright © 2018 Inloop s.r.o. All rights reserved.

import Foundation

final public class TextEffect: NSObject {
    private let style: TextStyle
    private let regex: RegularExpression

    var attributes: [NSAttributedStringKey: Any] {
        return style.attributes
    }

    public init(style: TextStyle, matching regex: RegularExpression) {
        self.style = style
        self.regex = regex
    }

    func ranges(in text: String) -> [NSRange] {
        return regex.ranges(in: text)
    }
}
