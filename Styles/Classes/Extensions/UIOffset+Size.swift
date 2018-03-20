//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

extension UIOffset {
    /// Represents size of an UIOffset
    public var size: CGSize {
        return CGSize(width: horizontal, height: vertical)
    }

    /// CGsize.zero - Represents zero offset
    public static let zero = UIOffset(horizontal: 0, vertical: 0)
}
