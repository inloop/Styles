//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

/**
 First represents `Match` which finds first string matching given condition
 @see `Match`
 */
public final class First: NSObject, Match {
    let string: String
    let ignoringCase: Bool

    /**
     Designated initializer
     - Parameter string: The string for which should firt occurence be found
     - Parameter ignoringCase: Should the case sensitivity be ignored? *Default value* `false`
     - Returns: New instance of First
    */
    public init(occurenceOf string: String, ignoringCase: Bool = false) {
        self.ignoringCase = ignoringCase
        self.string = ignoringCase ? string.lowercased() : string
    }

    /**
     Function returns all ranges found on given base string
     - Parameter base: The base string for which should be the ranges computed
     - Returns: Array of ranges for given string
    */
    public func ranges(in base: String) -> [NSRange] {
        let localBase = ignoringCase ? base.lowercased() : base
        guard let range = localBase.range(of: string) else { return [] }
        return [NSRange(range, in: base)]
    }
}

extension First {
    /// :nodoc:
    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? First else { return false }
        return string == other.string && ignoringCase == other.ignoringCase
    }
}
