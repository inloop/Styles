//  Copyright © 2018 Inloop s.r.o. All rights reserved.

import Foundation

public struct RegularExpression {
    let pattern: String
    let options: NSRegularExpression.Options

    public init(pattern: String, options: NSRegularExpression.Options = .caseInsensitive) {
        self.pattern = pattern
        self.options = options
    }

    public static func contains(_ string: String, ignoringCase: Bool = true) -> RegularExpression {
        return RegularExpression(pattern: string, options: ignoringCase ? .caseInsensitive : [])
    }

    public static func wordMatches(word: String, ignoringCase: Bool = true) -> RegularExpression {
        return RegularExpression(pattern: "\\b\(word)\\b", options: ignoringCase ? .caseInsensitive : [])
    }

    public static func wordStarts(with string: String, ignoringCase: Bool = true) -> RegularExpression {
        return RegularExpression(pattern: "\\b\(string)", options: ignoringCase ? .caseInsensitive : [])
    }

    public static func wordEnds(with string: String, ignoringCase: Bool = true) -> RegularExpression {
        return RegularExpression(pattern: "\(string)\\b", options: ignoringCase ? .caseInsensitive : [] )
    }

    public static let currency: RegularExpression = {
        return RegularExpression(pattern: "(-?\\d{1,3}((,|\\.)?\\d{3})*((,|\\.)\\d*?))(\\D|\\$)")
    }()

    public static let lastWord: RegularExpression = {
        return RegularExpression(pattern: "\\s(\\w+)(?>\\.|!|\\?)*$", options: [.caseInsensitive, .anchorsMatchLines])
    }()

    public static let firstWord: RegularExpression = {
        return RegularExpression(pattern: "^\\w+", options: [.caseInsensitive, .anchorsMatchLines])
    }()

    func ranges(in base: String) -> [NSRange] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            let matches = regex.matches(in: base, options: [], range: NSRange(base.startIndex..., in: base))
            var ranges: [NSRange] = []
            for match in matches {
                if match.numberOfRanges > 1 {
                    for index in 1..<match.numberOfRanges {
                        ranges.append(match.range(at: index))
                    }
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
