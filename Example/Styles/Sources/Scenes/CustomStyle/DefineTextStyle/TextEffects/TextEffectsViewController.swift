//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class TextEffectsViewController: UIViewController {
	@IBOutlet weak var textStyleLabel: UILabel!
	@IBOutlet weak var styleTypeControl: UISegmentedControl!
	@IBOutlet weak var matchTypeLabel: UILabel!

	var completion: ((_ effect: TextEffect.Definition) -> Void)?
	var effectsCount: Int = 1

	private lazy var styleDefinition = TextStyle.Definition(
		textStyle: TextStyle.empty,
		styleDescription: "let textStyle\(self.effectsCount) = TextStyle.empty"
	)

	private var match = MatchDefinition(
		match: First(occurenceOf: "awesome"),
		matchDescription: "First(occurenceOf: \"awesome\")"
	)

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Text effect"
	}

	@IBAction func selectMatch(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "MatchPicker", bundle: nil)
		guard let controller = storyboard.instantiateInitialViewController() as? MatchPickerViewController else { return }
		controller.completion = { [weak self] matchDefinition in
			self?.match = matchDefinition
			self?.matchTypeLabel.text = matchDefinition.matchDescription
		}
		navigationController?.pushViewController(controller, animated: true)
	}

	@IBAction func selectTextStyle(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "DefineTextStyle", bundle: nil)
		guard let controller = storyboard.instantiateInitialViewController() as? DefineTextStyleViewController else { return }
		controller.propertyCount = "\(effectsCount)"
		controller.delegate = self
		navigationController?.pushViewController(controller, animated: true)
	}

	@IBAction func applyAndExit(_ sender: UIButton) {
		let definition: TextEffect.Definition
		switch styleTypeControl.selectedSegmentIndex {
		case 0: definition = makeStyleDefinition()
		case 1:	definition = makeImageDefinition()
		default: fatalError()
		}
		navigationController?.popViewController(animated: true)
		completion?(definition)
	}

	private func makeStyleDefinition() -> TextEffect.Definition {
		let textEffect = TextEffect(style: styleDefinition.textStyle, matching: match.match)
		let description =
		"""
		TextEffect(
			style: textStyle\(effectsCount),
			matching: \(match.matchDescription)
		)
		"""

		return TextEffect.Definition(
			effect: textEffect,
			effectDescription: description,
			textStyleDescription: styleDefinition.styleDescription
		)
	}

	private func makeImageDefinition() -> TextEffect.Definition {
		let textEffect = TextEffect(
			image: #imageLiteral(resourceName: "doge"),
			style: styleDefinition.textStyle,
			matching: match.match
		)
		let description =
		"""
		TextEffect(
			image: #imageLiteral(resourceName: "doge"),
			style: textStyle\(effectsCount),
			matching: \(match.matchDescription)
		)
		"""

		return TextEffect.Definition(
			effect: textEffect,
			effectDescription: description,
			textStyleDescription: styleDefinition.styleDescription
		)
	}
}

extension TextEffectsViewController: StylePickerDelegate {
	func didPickTextStyleDefinition(_ definition: TextStyle.Definition) {
		styleDefinition = definition
		textStyleLabel.text = definition.styleDescription
	}

	func didPickViewStyleDefinition(_ definition: ViewStyle.Definition) {
		fatalError("Invalid config")
	}
}
