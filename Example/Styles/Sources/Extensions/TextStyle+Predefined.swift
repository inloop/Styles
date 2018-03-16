//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

extension TextStyle {
	struct Definition {
		let textStyle: TextStyle
		let styleDescription: String

		static let h1 = Definition(
			textStyle: .h1,
			styleDescription:
			"""
			static let h1 = TextStyle(
				.font(.preferredFont(forTextStyle: .largeTitle)),
				.foregroundColor(.black),
				.backgroundColor(.yellow),
				.paragraphStyle([
					.alignment(.center)
				]),
				.obliqueness(0.3),
				.shadow(.magenta),
				effects: [ everyOtherTilda ]
			)
			static let everyOtherTilda = TextEffect(
				style: cyanTextWithBlueShadow,
				matching: Regex("~.*?(~)")
			)
			"""
		)

		static let body = Definition(
			textStyle: .body,
			styleDescription:
			"""
			static let body = TextStyle(
				.font(.preferredFont(forTextStyle: .body)),
				.foregroundColor(.black),
				.backgroundColor(.yellow),
				.letterSpacing(1.5),
				.paragraphStyle([
					.alignment(.natural),
					.lineSpacing(2.5)
					]),
				.strikethrought(TextDecoration(
					style: .thick,
					pattern: .dash,
					color: .yellow
				)),
				.underline(TextDecoration(
					style: .single,
					pattern: .dashDotDot,
					byWord: true,
					color: .red
				))
			)
			"""
		)

		static let highlight = Definition(
			textStyle: .highlight,
			styleDescription:
			"""
			static let body = TextStyle(
				.font(.preferredFont(forTextStyle: .body)),
				.foregroundColor(.black),
				.backgroundColor(.yellow),
				.letterSpacing(1.5),
				.paragraphStyle([
					.alignment(.natural),
					.lineSpacing(2.5)
					]),
				.strikethrought(TextDecoration(
					style: .thick,
					pattern: .dash,
					color: .yellow
				)),
				.underline(TextDecoration(
					style: .single,
					pattern: .dashDotDot,
					byWord: true,
					color: .red
				))
			)
			static let highlight = body.updating(
				.backgroundColor(.blue),
				.foregroundColor(.green),
				.font(.preferredFont(forTextStyle: .largeTitle))
			)
			"""
		)

		static let bigRed = Definition(
			textStyle: .bigRed,
			styleDescription:
			"""
			static let bigRed = TextStyle(
				.font(.preferredFont(forTextStyle: .largeTitle)),
				.foregroundColor(.red)
			)
			"""
		)

		static let bigGreen = Definition(
			textStyle: .bigGreen,
			styleDescription:
			"""
			static let bigGreen = TextStyle(
				.font(.preferredFont(forTextStyle: .largeTitle)),
				.foregroundColor(.green)
			)
			"""
		)

		static let cyanTextWithBlueShadow = Definition(
			textStyle: .cyanTextWithBlueShadow,
			styleDescription:
			"""
			static let cyanTextWithBlueShadow = TextStyle(
				.foregroundColor(.cyan),
				.shadow(.blue)
			)
			"""
		)

		static let styleWithEffects = Definition(
			textStyle: .styleWithEffects,
			styleDescription:
			"""
			static let styleWithEffects = TextStyle(
				.font(.preferredFont(forTextStyle: .body)),
				.backgroundColor(.yellow),
				effects: [
					bigRedFirstWord,
					bigGreenLastWord,
					doge
				]
			)

			static let bigRedFirstWord = TextEffect(
				style: bigRed,
				matching: First(occurenceOf: "Styles")
			)
			static let bigGreenLastWord = TextEffect(
				style: bigGreen,
				matching: Block { $0.range(of: "awesome") }
			)
			static let everyOtherTilda = TextEffect(
				style: cyanTextWithBlueShadow,
				matching: Regex("~.*?(~)")
			)
			static let doge = TextEffect(
				image: #imageLiteral(resourceName: "doge"), style:
				cyanTextWithBlueShadow,
				matching: First(occurenceOf: " i")
			)
			"""
		)

		static let greenHeadline = Definition(
			textStyle: .greenHeadline,
			styleDescription:
			"""
			static let greenHeadline = TextStyle(
				.font(.preferredFont(forTextStyle: .headline)),
				.foregroundColor(.green)
			)
			"""
		)

		static let magentaFootnote = Definition(
			textStyle: .magentaFootnote,
			styleDescription:
			"""
			static let magentaFootnote = TextStyle(
				.font(.preferredFont(forTextStyle: .footnote)),
				.foregroundColor(.magenta)
			)
			"""
		)

		static let largeTitle = Definition(
			textStyle: .largeTitle,
			styleDescription:
			"""
			static let largeTitle = TextStyle(
				.font(.preferredFont(forTextStyle: .largeTitle)),
				.foregroundColor(.white),
				.backgroundColor(.magenta)
			)
			"""
		)

		static let blueFootnote = Definition(
			textStyle: .blueFootnote,
			styleDescription:
			"""
			static let blueFootnote = magentaFootnote.updating(.foregroundColor(.blue))
			\(magentaFootnote.styleDescription)
			"""
		)
	}
}
