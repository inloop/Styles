//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

protocol ValueComparable {
    static func ===(lhs: Self, rhs: Self) -> Bool
}

extension Array where Element == TextStyle.Property {
    var attributes: [NSAttributedStringKey: Any] {
        return Dictionary(uniqueKeysWithValues: flatMap { $0.attribute })
    }
}

extension Array where Element: Equatable {
    func updating(_ other: [Element]) -> [Element] {
        var new = self
        for element in other {
            if let index = new.index(of: element) {
                new[index] = element
            } else {
                new.append(element)
            }
        }
        return new
    }

    func not(in other: [Element]) -> [Element] {
        return filter { !other.contains($0) }
    }
}

extension Array where Element: ValueComparable {
    func removing(_ other: [Element]) -> [Element] {
        return filter { (element) -> Bool in
            return !other.contains {
                $0 === element
            }
        }
    }

}
