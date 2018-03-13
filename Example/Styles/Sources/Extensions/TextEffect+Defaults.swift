//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

extension TextEffect {
	static let bigRedFirstWord = TextEffect(
		style: .bigRed,
		matching: First(occurenceOf: "Styles")
	)
	static let bigGreenLastWord = TextEffect(
		style: .bigGreen,
		matching: Block { $0.range(of: "awesome") }
	)
	static let everyOtherTilda = TextEffect(
		style: .cyanTextWithBlueShadow,
		matching: Regex("~.*?(~)")
	)
	static let doge = TextEffect(
		image: #imageLiteral(resourceName: "doge"),
		style: .cyanTextWithBlueShadow,
		matching: First(occurenceOf: " i")
	)
}
