//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

private enum RangeType {
    case foundation(NSRange)
    case swift(Swift.Range<String.Index>)
}

/**
 Range is a convenience class that represents `Match` with concrete ranges.
 Useful for labels with hardcoded strings.
 @see `Match`
*/
public final class Range: NSObject, Match {
    private let ranges: [RangeType]

    /// Intialize `Range` with location and length.
    ///
    /// - Parameters:
    ///   - location: starting location
    ///   - length: length of the range
    public convenience init(location: Int, length: Int) {
        self.init(ranges: [.foundation(NSRange(location: location, length: length))])
    }

    /// Intialize `Range` with `NSRange`.
    ///
    /// - Parameter range: range to be matched
    public convenience init(_ range: NSRange) {
        self.init(ranges: [.foundation(range)])
    }

    /// Intialize `Range` with multiple `NSRange`s.
    ///
    /// - Parameter ranges: ranges to be matched
    public convenience init(_ ranges: [NSRange]) {
        self.init(ranges: ranges.map { .foundation($0) })
    }

    /// Intialize `Range` with `Swift.Range`.
    ///
    /// - Parameter range: range to be matched
    public convenience init(_ range: Swift.Range<String.Index>) {
        self.init(ranges: [range].map { .swift($0) })
    }

    /// Intialize `Range` with multiple `Swift.Range`s.
    ///
    /// - Parameter ranges: ranges to be matched
    public convenience init(_ ranges: [Swift.Range<String.Index>]) {
        self.init(ranges: ranges.map { .swift($0) })
    }

    private init(ranges: [RangeType]) {
        self.ranges = ranges
        super.init()
    }

    public func ranges(in base: String) -> [NSRange] {
        return ranges.map { range in
            switch range {
            case .foundation(let nsRange):
                return nsRange
            case .swift(let swiftRange):
                return NSRange(swiftRange, in: base)
            }
        }
    }
}
