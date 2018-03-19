//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

private enum RangeType {
    case foundation(NSRange)
    case swift(Swift.Range<String.Index>)
}

public final class Range<T>: NSObject, Match {
    private let ranges: [RangeType]

    public convenience init(location: Int, length: Int) {
        self.init(ranges: [.foundation(NSRange(location: location, length: length))])
    }

    public convenience init(_ range: NSRange) {
        self.init(ranges: [.foundation(range)])
    }

    public convenience init(_ ranges: [NSRange]) {
        self.init(ranges: ranges.map { .foundation($0) })
    }

    public convenience init(_ range: Swift.Range<String.Index>) {
        self.init(ranges: [range].map { .swift($0) })
    }

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
