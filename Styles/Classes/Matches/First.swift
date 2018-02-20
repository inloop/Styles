//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

public final class First: NSObject, Match {
    let string: String
    let ignoringCase: Bool

    public init(occurenceOf string: String, ignoringCase: Bool = false) {
        self.ignoringCase = ignoringCase
        self.string = ignoringCase ? string.lowercased() : string
    }

    public func ranges(in base: String) -> [NSRange] {
        let localBase = ignoringCase ? base.lowercased() : base
        guard let range = localBase.range(of: string) else { return [] }
        return [NSRange(range, in: base)]
    }
}

extension First {
    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? First else { return false }
        return string == other.string && ignoringCase == other.ignoringCase
    }
}
