//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

extension TextStyle.WritingDirectionOverride {
    var description: String {
        switch self {
        case .leftToRightEmbedding:
            return "Left to right embedding"
        case .leftToRightOverride:
            return "Right to left override"
        case .rightToLeftOverride:
            return "Right to left override"
        case .rightToLeftEmbedding:
            return "Right to left embedding"
        }
    }
    
    var codeDescription: String {
        switch self {
        case .leftToRightEmbedding:
            return ".leftToRightEmbedding"
        case .leftToRightOverride:
            return ".leftToRightOverride"
        case .rightToLeftOverride:
            return ".rightToLeftOverride"
        case .rightToLeftEmbedding:
            return ".rightToLeftEmbedding"
        }
    }
}
