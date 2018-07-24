//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

extension TextDecoration {
    struct Definition {
        let decoration: TextDecoration
        let decorationDescription: String
    }
}

extension TextDecoration.Pattern {
    var codeDescription: String {
        switch self {
        case .solid: return ".solid"
        case .dot: return ".dot"
        case .dash: return ".dash"
        case .dashDot: return ".dashDot"
        case .dashDotDot: return ".dashDotDot"
        }
    }
}

extension TextDecoration.Style {
    var codeDescription: String {
        switch self {
        case .single: return ".single"
        case .thick: return ".thick"
        case .double: return ".double"
        }
    }
}
