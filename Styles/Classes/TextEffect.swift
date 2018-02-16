//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

public protocol Match {
    func ranges(in base: String) -> [NSRange]
}

final public class TextEffect: NSObject {
    private let style: TextStyle
    private let match: Match

    var attributes: [NSAttributedStringKey: Any] {
        return style.attributes
    }

    public init(style: TextStyle, matching match: Match) {
        self.style = style
        self.match = match
    }

    func ranges(in text: String) -> [NSRange] {
        return match.ranges(in: text)
    }
}
