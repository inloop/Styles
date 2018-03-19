//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

public final class Block: NSObject, Match {
    public typealias Find = (_ base: String) -> [Swift.Range<String.Index>?]
    let find: Find

    public init(_ find: @escaping Find) {
        self.find = find
    }

    public init(_ findSimple: @escaping (String) -> Swift.Range<String.Index>?) {
        self.find = { [findSimple($0)] }
    }

    public func ranges(in base: String) -> [NSRange] {
        return find(base)
            .flatMap { $0 }
            .map { NSRange($0, in: base) }
    }
}
