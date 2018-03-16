//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class TextDecorationViewController: UIViewController {
	@IBOutlet weak var patternLabel: UILabel!
	@IBOutlet weak var styleLabel: UILabel!
	@IBOutlet weak var byWordSwitch: UISwitch!
	@IBOutlet weak var colorView: UIView!

	var completion: ((_ decoration: TextDecoration.Definition) -> Void)?
	private var style: TextDecoration.Style?
	private var pattern: TextDecoration.Pattern?
	var propertyName: String?

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "TextDecoration - \(propertyName ?? "decoration")"
	}

	@IBAction func selectPattern(_ sender: UIButton) {
		let controller = PatternPickerViewController()
		controller.completion = { [weak self] pattern in
			self?.pattern = pattern
			self?.patternLabel.text = "Pattern: \(pattern.codeDescription)"
		}
		navigationController?.pushViewController(controller, animated: true)
	}

	@IBAction func selectStyle(_ sender: UIButton) {
		let controller = StylePickerViewController()
		controller.completion = { [weak self] style in
			self?.style = style
			self?.styleLabel.text = "Style: \(style.codeDescription)"
		}
		navigationController?.pushViewController(controller, animated: true)
	}

	@IBAction func selectColor(_ sender: UIButton) {
		guard let controller = ColorPickerViewController.makeInstance() else { return }
		controller.completion = { [weak self] color in
			self?.colorView.backgroundColor = color
		}
		navigationController?.pushViewController(controller, animated: true)
	}

	@IBAction func applyAndExit(_ sender: UIButton) {
		guard let style = style, let pattern = pattern else {
			let controller = UIAlertController(
				title: "Mandatory",
				message: "Style and pattern is mandatory",
				preferredStyle: .alert
			)
			controller.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
			present(controller, animated: true, completion: nil)
			return
		}
		let decoration = TextDecoration(
			style: style,
			pattern: pattern,
			byWord: byWordSwitch.isOn,
			color: colorView.backgroundColor
		)
		let decorationName = propertyName ?? "decoration"
		let description =
		"""
		let \(decorationName) = TextDecoration(
			style: \(style.codeDescription),
			pattern: \(pattern.codeDescription),
			byWord: \(byWordSwitch.isOn),
			color: \(colorView.backgroundColor?.codeDescription ?? "nil")
		)
		"""
		let definition = TextDecoration.Definition(
			decoration: decoration,
			decorationDescription: description
		)
		completion?(definition)
		navigationController?.popViewController(animated: true)
	}
}
