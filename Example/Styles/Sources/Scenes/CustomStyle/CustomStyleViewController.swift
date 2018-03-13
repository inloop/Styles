//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

protocol StylePickerDelegate: class {
	func didPickViewStyleDefinition(_ definition: ViewStyle.Definition)
	func didPickTextStyleDefinition(_ definition: ViewStyle.Definition)
}

final class CustomStyleViewController: UIViewController {
	@IBOutlet weak var textLabel: UILabel!
	@IBOutlet weak var viewStyleDescriptionLabel: UILabel!
	@IBOutlet weak var textStyleDescriptionLabel: UILabel!

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.destination {
		case let controller as DefineViewStyleViewController:
			controller.delegate = self
			break
		default:
			break
		}
	}
}

extension CustomStyleViewController: StylePickerDelegate {
	func didPickTextStyleDefinition(_ definition: ViewStyle.Definition) {

	}

	func didPickViewStyleDefinition(_ definition: ViewStyle.Definition) {
		viewStyleDescriptionLabel.text = definition.styleDescription
		textLabel.viewStyle = definition.viewStyle
	}
}
