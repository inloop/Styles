//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

extension UIOffset {
    var size: CGSize {
        return CGSize(width: horizontal, height: vertical)
    }

    public static let zero = UIOffset(horizontal: 0, vertical: 0)
}
