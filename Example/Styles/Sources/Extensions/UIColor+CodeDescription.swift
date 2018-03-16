//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

extension UIColor {
    var codeDescription: String {
        var a: CGFloat = 1
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return "UIColor(red: \(r), green: \(g) , blue: \(b) , alpha: \(a))"
    }
}
