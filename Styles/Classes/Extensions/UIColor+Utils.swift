//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

extension UIColor {
    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: 255.0, alpha: a)
    }
}
