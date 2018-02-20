//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

extension NSAttributedString {
    func mutable() -> NSMutableAttributedString {
        return mutableCopy() as! NSMutableAttributedString
    }
}
