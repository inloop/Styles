//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

/**
 Regex represents `Match` by Regular expression.
 @see `Match`
*/
public final class Regex: NSObject, Match {
    let pattern: String
    let options: NSRegularExpression.Options

    /**
     Designated initializer
     - Parameter pattern: The Regular expression patter
     - Parameter options: The Regular expression options. *Default value* .caseInsensitive
     - Returns: New instance of Regex
     - SeeAlso: `NSRegularExpression.Options` for options.
    */
    public init(_ pattern: String, options: NSRegularExpression.Options = .caseInsensitive) {
        self.pattern = pattern
        self.options = options
    }

    /// \bstring\b
    /**
     The Regex representing the pattern of `\bstring\b`
     - Parameter string: The string which should the expression match
     - Parameter ignoringCase: Should ignore case? *Default value* true
     - Returns: New instance of `Regex`

     ```swift
     Regex("\\b\(string)\\b", options: ignoringCase ? .caseInsensitive : [])
     ```
     */
    public static func wordMatches(string: String, ignoringCase: Bool = true) -> Regex {
        return Regex("\\b\(string)\\b", options: ignoringCase ? .caseInsensitive : [])
    }

    /**
     The Regex representing the pattern of `\bstring`
     - Parameter string: The string with which should the expression start
     - Parameter ignoringCase: Should ignore case? *Default value* true
     - Returns: New instance of `Regex`

     ```swift
     Regex("\\b\(string)", options: ignoringCase ? .caseInsensitive : [])
     ```
    */
    public static func wordStarts(with string: String, ignoringCase: Bool = true) -> Regex {
        return Regex("\\b\(string)", options: ignoringCase ? .caseInsensitive : [])
    }

    /**
     The Regex representing the pattern of `string\b`
     - Parameter string: The string with which should the expression end
     - Parameter ignoringCase: Should ignore case? *Default value* true
     - Returns: New instance of `Regex`

     ```swift
     Regex("\(string)\\b", options: ignoringCase ? .caseInsensitive : [])
     ```
    */
    public static func wordEnds(with string: String, ignoringCase: Bool = true) -> Regex {
        return Regex("\(string)\\b", options: ignoringCase ? .caseInsensitive : [] )
    }

    /**
     The Regex representing the pattern of `\s(\w+)(?>\.|!|\?)*$`
     ```swift
     Regex("\s(\w+)(?>\.|!|\?)*$", options: [.caseInsensitive, .anchorsMatchLines])
     ```
     */
    public static let lastWord: Regex = {
        return Regex("\\s(\\w+)(?>\\.|!|\\?)*$", options: [.caseInsensitive, .anchorsMatchLines])
    }()

    /**
     The Regex representing the pattern of `^\\w+`
     ```swift
     Regex("^\\w+", options: [.caseInsensitive, .anchorsMatchLines])
     ```
    */
    public static let firstWord: Regex = {
        return Regex("^\\w+", options: [.caseInsensitive, .anchorsMatchLines])
    }()

    /**
     Function returns all ranges found on given base string using the regular expression
     - Parameter base: The base string for which should be the ranges computed
     - Returns: Array of ranges for given string
     */
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
