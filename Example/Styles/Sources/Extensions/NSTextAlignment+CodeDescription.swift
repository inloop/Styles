//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

extension NSTextAlignment {
    var codeDescription: String {
        switch self {
        case .center:
            return ".center"
        case .left:
            return ".left"
        case .right:
            return ".right"
        case .justified:
            return ".justified"
        case .natural:
            return ".natural"
        }
    }
}
