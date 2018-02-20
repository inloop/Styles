//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

public final class Regex: NSObject, Match {
    let pattern: String
    let options: NSRegularExpression.Options

    public init(_ pattern: String, options: NSRegularExpression.Options = .caseInsensitive) {
        self.pattern = pattern
        self.options = options
    }

    /// \bstring\b
    public static func wordMatches(string: String, ignoringCase: Bool = true) -> Regex {
        return Regex("\\b\(string)\\b", options: ignoringCase ? .caseInsensitive : [])
    }

    /// \bstring
    public static func wordStarts(with string: String, ignoringCase: Bool = true) -> Regex {
        return Regex("\\b\(string)", options: ignoringCase ? .caseInsensitive : [])
    }

    /// string\b
    public static func wordEnds(with string: String, ignoringCase: Bool = true) -> Regex {
        return Regex("\(string)\\b", options: ignoringCase ? .caseInsensitive : [] )
    }

    /// \s(\w+)(?>\.|!|\?)*$
    public static let lastWord: Regex = {
        return Regex("\\s(\\w+)(?>\\.|!|\\?)*$", options: [.caseInsensitive, .anchorsMatchLines])
    }()

    /// ^\w+
    public static let firstWord: Regex = {
        return Regex("^\\w+", options: [.caseInsensitive, .anchorsMatchLines])
    }()

    public func ranges(in base: String) -> [NSRange] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            let matches = regex.matches(in: base, options: [], range: NSRange(base.startIndex..., in: base))
            var ranges: [NSRange] = []
            for match in matches {
                if match.containsCaptureGroupsRanges {
                    ranges.append(contentsOf: match.captureGroupsRanges)
                } else {
                    ranges.append(match.range)
                }
            }
            return ranges
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

extension Regex {
    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? Regex else { return false }
        return pattern == other.pattern && options == other.options
    }
}

private extension NSTextCheckingResult {
    var containsCaptureGroupsRanges: Bool {
        return numberOfRanges > 1
    }

    var captureGroupsRanges: [NSRange] {
        return (1..<numberOfRanges).map(range(at:))
    }
}
