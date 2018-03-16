//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

extension Shadow {
    struct ShadowDefinition {
        let shadow: Shadow
        let shadowDescription: String
    }

    static let magenta = Shadow(
        color: .magenta,
        offset: UIOffset(horizontal: 1, vertical: 1),
        radius: 4
    )

    static let blue = Shadow(
        color: .blue,
        offset: UIOffset(horizontal: 4, vertical: 4),
        radius: 4
    )

    static let red = Shadow(
        color: .red,
        offset: UIOffset(horizontal: 0, vertical: 8),
        radius: 16
    )
}
