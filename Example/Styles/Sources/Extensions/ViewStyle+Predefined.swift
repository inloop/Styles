//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

extension ViewStyle {
	struct Definition {
		let viewStyle: ViewStyle
		let styleDescription: String

		static let rounded = Definition(
			viewStyle: .rounded,
			styleDescription:
			"""
			let rounded = ViewStyle(
				.cornerRadius(10),
				.borderWidth(3),
				.borderColor(.red),
				.opacity(0.8)
			)
			"""
		)

		static let appColor = Definition(
			viewStyle: .appColor,
			styleDescription:
			"""
			let appColor = ViewStyle(
				.backgroundColor(.gray),
				.tintColor(.blue)
			)
			"""
		)

		static let redColor = Definition(
			viewStyle: .redColor,
			styleDescription:
			"""
			let redColor = ViewStyle(
				.backgroundColor(.red),
				.shadow(redShadow)
			)
			let redShadow = Shadow(
				color: .red,
				offset: UIOffset(horizontal: 0, vertical: 8),
				radius: 16
			)
			"""
		)

		static let red = Definition(
			viewStyle: .red,
			styleDescription:
			"""
			let red = ViewStyle(
				.borderColor(.red),
				.borderWidth(0.5),
				.cornerRadius(0),
				.shadow(redShadow)
			)
			let redShadow = Shadow(
				color: .red,
				offset: UIOffset(horizontal: 0, vertical: 8),
				radius: 16
			)
			"""
		)

		static let blue = Definition(
			viewStyle: .blue,
			styleDescription:
			"""
			\(Definition.red.styleDescription)
			static let blue = red.updating(
			.borderColor(.blue),
			.cornerRadius(10),
			.shadow(.none)
			)
			"""
		)

		static let roundedApp = Definition(
			viewStyle: .rounded + .appColor,
			styleDescription:
			"""
			let roundedApp = rounded + appColor
			\(Definition.rounded.styleDescription)
			\(Definition.appColor.styleDescription)
			"""
		)
	}
}
