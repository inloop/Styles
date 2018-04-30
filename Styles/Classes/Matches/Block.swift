//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

/**
 Block represents `Match` which is executed in block
 @see `Match`
 */
public final class Block: NSObject, Match {
    /**
     Defines Find closure
     - Parameter base: Type of string
     - Returns: Optional array of ranges of string indexes
    */
    public typealias Find = (_ base: String) -> [Swift.Range<String.Index>?]
    let find: Find

    /**
     Designated initializer
     - Parameter find: The `Find` closure
     - Returns: new instance of Block
    */
    public init(_ find: @escaping Find) {
        self.find = find
    }

    /**
     Designated initializer
     - Parameter findSimple: The closure which accepts string and returns optional range of String.Index
     - Returns: new instance of Block
     */
    public init(_ findSimple: @escaping (String) -> Swift.Range<String.Index>?) {
        self.find = { [findSimple($0)] }
    }

    /**
     Function returns all ranges found by `find` closure on given string
     - Parameter base: The base string for which should be the ranges computed
     - Returns: Array of ranges for given string
    */
    public func ranges(in base: String) -> [NSRange] {
        return find(base)
            .compactMap { $0 }
            .map { NSRange($0, in: base) }
    }
}
