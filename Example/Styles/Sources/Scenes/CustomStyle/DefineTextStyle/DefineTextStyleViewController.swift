//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class DefineTextStyleViewController: UIViewController {
	@IBOutlet weak var exampleText: UILabel!
	@IBOutlet weak var fontLabel: UILabel!
	@IBOutlet weak var fontSizeLabel: UILabel!
	@IBOutlet weak var fontSizeSlider: UISlider!
	@IBOutlet weak var backgroundColorView: UIView!
	@IBOutlet weak var foregroundColorView: UIView!
	@IBOutlet weak var lineSpacingLabel: UILabel!
	@IBOutlet weak var lineSpacingSlider: UISlider!
	@IBOutlet weak var alignmentControl: UISegmentedControl!
	@IBOutlet weak var letterSpacingLabel: UILabel!
	@IBOutlet weak var letterSpacingSlider: UISlider!
	@IBOutlet weak var obliquenessLabel: UILabel!
	@IBOutlet weak var obliquenessSlider: UISlider!
	@IBOutlet weak var baselineOffsetLabel: UILabel!
	@IBOutlet weak var baselineOffsetSlider: UISlider!
	@IBOutlet weak var textEffectsLabel: UILabel!

	private let alignments = [NSTextAlignment.left, .right, .center, .justified, .natural]
	fileprivate var shadowDefinition: Shadow.ShadowDefinition?
	fileprivate var strikethrioughDefinition: TextDecoration.Definition?
	fileprivate var underlineDefinition: TextDecoration.Definition?
	fileprivate var font = UIFont.systemFont(ofSize: 17)
	fileprivate var selectedWritingDirectionOverrides = [TextStyle.WritingDirectionOverride]()
	fileprivate var textEffects = [TextEffect.Definition]()
	var propertyCount = ""
	weak var delegate: StylePickerDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Define text style"
		setTextStyle()
	}

	fileprivate func setTextStyle() {
		let effects = textEffects.map { $0.effect }
		var style = TextStyle(
			.foregroundColor(foregroundColorView.backgroundColor ?? .black),
			.backgroundColor(backgroundColorView.backgroundColor ?? .white),
			.font(font),
			.paragraphStyle([
				.alignment(alignments[alignmentControl.selectedSegmentIndex]),
				.lineSpacing(CGFloat(lineSpacingSlider.value))
            ]),
			.letterSpacing(CGFloat(letterSpacingSlider.value)),
			.obliqueness(Double(obliquenessSlider.value)),
			.writingDirectionOverrides(selectedWritingDirectionOverrides),
			.baselineOffset(Double(baselineOffsetSlider.value))
			, effects: effects
		)
		if let shadow = shadowDefinition?.shadow {
			style = style.updating(.shadow(shadow))
		}
		if let strikethrough = strikethrioughDefinition?.decoration {
			style = style.updating(.strikethrought(strikethrough))
		}
		if let underline = underlineDefinition?.decoration {
			style = style.updating(.underline(underline))
		}
		exampleText.textStyle = style
	}

	private func presentColorPickerWithCompletion(_ completion: @escaping (_ color: UIColor?) -> Void) {
		guard let controller = ColorPickerViewController.makeInstance() else { return }
		controller.completion = completion
		navigationController?.pushViewController(controller, animated: true)
	}

	private func selectTextDecoration(_ propertyName: String = "decoration", _ completion: @escaping (_ definition: TextDecoration.Definition) -> Void) {
		let storyboard = UIStoryboard(name: "TextDecoration", bundle: nil)
		guard let controller = storyboard.instantiateInitialViewController() as? TextDecorationViewController else { return }
		controller.propertyName = propertyName
		controller.completion = completion
		navigationController?.pushViewController(controller, animated: true)
	}

	fileprivate func makeFont(_ name: String = "") {
		let fontName = name.isEmpty ? font.fontName : name
		font = UIFont(name: fontName, size: CGFloat(fontSizeSlider.value)) ?? UIFont.systemFont(ofSize: 17)
		setTextStyle()
	}

	@IBAction func selectFont(_ sender: UIButton) {
		let controller = FontPickerViewController()
		controller.delegate = self
		navigationController?.pushViewController(controller, animated: true)
	}

	@IBAction func selectBackgroundColor(_ sender: UIButton) {
		presentColorPickerWithCompletion { [weak self] color in
			self?.backgroundColorView.backgroundColor = color
			self?.setTextStyle()
		}
	}

	@IBAction func selectForegroundColor(_ sender: UIButton) {
		presentColorPickerWithCompletion { [weak self] color in
			self?.foregroundColorView.backgroundColor = color
			self?.setTextStyle()
		}
	}

	@IBAction func sliderValueChanged(_ sender: UISlider) {
		let value = roundf(sender.value)
		sender.value = value

		switch sender.tag {
		case fontSizeSlider.tag:
			fontSizeLabel.text = "Font size \(value)"
		case lineSpacingSlider.tag:
			lineSpacingLabel.text = "Line spacing \(value)"
		case letterSpacingSlider.tag:
			letterSpacingLabel.text = "Letter spacing \(value)"
		case obliquenessSlider.tag:
			obliquenessLabel.text = "Obliqueness \(value)"
		case baselineOffsetSlider.tag:
			baselineOffsetLabel.text = "Baseline offset \(value)"
		default: break
		}
		makeFont()
	}

	@IBAction func alignmentChanged(_ sender: UISegmentedControl) {
		setTextStyle()
	}

	@IBAction func selectShadow(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Shadow", bundle: nil)
		guard let controller = storyboard.instantiateInitialViewController() as? ShadowViewController else { return }
		controller.delegate = self
		navigationController?.pushViewController(controller, animated: true)
	}

	@IBAction func selectStrikethrough(_ sender: UIButton) {
		selectTextDecoration("strikethrought") { [weak self] definition in
			self?.strikethrioughDefinition = definition
			self?.setTextStyle()
		}
	}
	
	@IBAction func selectUnderline(_ sender: UIButton) {
		selectTextDecoration("underline") { [weak self] definition in
			self?.underlineDefinition = definition
			self?.setTextStyle()
		}
	}

	@IBAction func selectWritingDirection(_ sender: UIButton) {
		let controller = WritingDirectionPickerViewController()
		controller.selectedWritingDirectionOverrides = selectedWritingDirectionOverrides
		controller.completion = { [weak self] selection in
			self?.selectedWritingDirectionOverrides = selection
			self?.setTextStyle()
		}
		navigationController?.pushViewController(controller, animated: true)
	}

	@IBAction func selectTextEffect(_ sender: UIButton) {
		let controller = TextEffectsListViewController()
		controller.completion = { [weak self] effects in
			self?.textEffects = effects
			self?.textEffectsLabel.text = "Text effects (\(effects.count))"
			self?.setTextStyle()
		}
		controller.textEffects = textEffects
		navigationController?.pushViewController(controller, animated: true)
	}

	@IBAction func applyAndExit(_ sender: UIButton) {
		var styleDescription =
		"""
		let textStyle\(propertyCount) = TextStyle(
			.foregroundColor(\((foregroundColorView.backgroundColor ?? .black).codeDescription)),
			.backgroundColor(\((backgroundColorView.backgroundColor ?? .white).codeDescription)),
			.font(\(font)),
			.paragraphStyle([
				.alignment(\(alignments[alignmentControl.selectedSegmentIndex].codeDescription)),
				.lineSpacing(\(CGFloat(lineSpacingSlider.value)))
			]),
			.letterSpacing(\(CGFloat(letterSpacingSlider.value))),
			.obliqueness(\(Double(obliquenessSlider.value))),
			.writingDirectionOverrides([\(selectedWritingDirectionOverrides.map { $0.codeDescription }.joined(separator: ","))]),
			.baselineOffset(\(Double(baselineOffsetSlider.value)))
		"""
		styleDescription = addSpecialEffectsDescription(styleDescription)
		styleDescription = addTextEffectsDescription(styleDescription)

		navigationController?.popViewController(animated: true)
		delegate?.didPickTextStyleDefinition(
			TextStyle.Definition(
				textStyle: exampleText.textStyle,
				styleDescription: styleDescription
			)
		)
	}

	private func addSpecialEffectsDescription(_ descriptionString: String) -> String {
		var styleDescription = descriptionString
		styleDescription.append("\(shadowDefinition != nil ? ",\n        .shadow(shadow)" : "")")
		styleDescription.append("\(underlineDefinition != nil ? ",\n        .underline(underline)" : "")")
		styleDescription.append("\(strikethrioughDefinition != nil ? ",\n        .strikethrought(strikethrought)" : "")")
		styleDescription.append(",\n        textEffects: effects\(propertyCount)\n)")
		if let shadowDescription = shadowDefinition?.shadowDescription {
			styleDescription.append("\n\(shadowDescription)")
		}
		if let strikethroughtDescription = strikethrioughDefinition?.decorationDescription {
			styleDescription.append("\n\(strikethroughtDescription)")
		}
		if let underlineDescription = underlineDefinition?.decorationDescription {
			styleDescription.append("\n\(underlineDescription)")
		}
		return styleDescription
	}

	private func addTextEffectsDescription(_ descriptionString: String) -> String {
		var styleDescription = descriptionString

		styleDescription.append(
			"""
			\n
			let effects\(propertyCount) = [
			\(textEffects.map { $0.effectDescription }.joined(separator: ",\n"))
			]
			"""
		)
		if textEffects.count > 0 {
			styleDescription.append(
				"""
				\n
				\(textEffects.map { $0.textStyleDescription }.joined(separator: ",\n"))
				"""
			)
		}
		return styleDescription
	}
}

extension DefineTextStyleViewController: ShadowPickerDelegate {
	func didPickShadow(_ definition: Shadow.ShadowDefinition) {
		shadowDefinition = definition
		setTextStyle()
	}
}

extension DefineTextStyleViewController: FontPickerDelegate {
	func didPickFontWithName(_ fontName: String) {
		navigationController?.popViewController(animated: true)
		fontLabel.text = fontName
		makeFont(fontName)
	}
}

