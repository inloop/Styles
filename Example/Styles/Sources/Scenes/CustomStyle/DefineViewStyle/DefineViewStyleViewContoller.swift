//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class DefineViewStyleViewController: UIViewController {
	@IBOutlet weak var backgroundColorView: UIView!
	@IBOutlet weak var tintColorView: UIView!
	@IBOutlet weak var borderWidthSlider: UISlider!
	@IBOutlet weak var borderColorView: UIView!
	@IBOutlet weak var cornerRadiusSlider: UISlider!
	@IBOutlet weak var opacitySlider: UISlider!
	@IBOutlet weak var opacityLabel: UILabel!
	@IBOutlet weak var cornerRadiusLabel: UILabel!
	@IBOutlet weak var borderWidthLabel: UILabel!

	private var shadow = Shadow.none
	private var shadowDescription = """
	let shadow = Shadow(
		color: .black,
		offset: UIOffset(horizontal: 0, vertical: -3),
		radius: 3,
		opacity: 0,
		shouldRasterizeLayer: false,
		rasterizationScale: 1.0
	)
	"""
	weak var delegate: StylePickerDelegate?


	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func borderWidthChanged(_ sender: UISlider) {
		let value = roundf(sender.value)
		sender.value = value
		borderWidthLabel.text = "BorderWidth (\(value))"
	}
	@IBAction func cornerRadiusChanged(_ sender: UISlider) {
		let value = roundf(sender.value)
		sender.value = value
		cornerRadiusLabel.text = "CornerRadius (\(value))"
	}

	@IBAction func opacityChnaged(_ sender: UISlider) {
		opacityLabel.text = "Opacity (\(sender.value))"
	}

	@IBAction func applyAndExit(_ sender: Any) {
		let definition = ViewStyle.Definition(
			viewStyle: ViewStyle(
				.backgroundColor(backgroundColorView.backgroundColor),
				.tintColor(tintColorView.backgroundColor),
				.cornerRadius(CGFloat(cornerRadiusSlider.value)),
				.borderColor(borderColorView.backgroundColor ?? .black),
				.borderWidth(CGFloat(borderWidthSlider.value)),
				.cornerRadius(CGFloat(cornerRadiusSlider.value)),
				.opacity(opacitySlider.value),
				.shadow(shadow)
			),
			styleDescription:
			"""
			let style = ViewStyle(
				.backgroundColor(\(backgroundColorView.backgroundColor.debugDescription)),
				.tintColor(\(tintColorView.backgroundColor.debugDescription)),
				.cornerRadius(\(CGFloat(cornerRadiusSlider.value)),
				.borderColor(\((borderColorView.backgroundColor ?? .black).debugDescription)),
				.borderWidth(\(CGFloat(borderWidthSlider.value))),
				.cornerRadius(\(CGFloat(cornerRadiusSlider.value))),
				.opacity(\(opacitySlider.value),
				.shadow(shadow)
			)
			\(shadowDescription)
			"""
		)
		delegate?.didPickViewStyleDefinition(definition)
		navigationController?.popViewController(animated: true)
	}
	private func presentColorPickerWithCompletion(_ completion: @escaping (_ color: UIColor?) -> Void) {
		guard let controller = ColorPickerViewController.makeInstance() else { return }
		controller.completion = completion
		self.navigationController?.pushViewController(controller, animated: true)
	}

	@IBAction func selectBackgroundColor(_ sender: UIButton) {
		presentColorPickerWithCompletion { [weak self] color in
			self?.backgroundColorView.backgroundColor = color
		}
	}

	@IBAction func selectTintColor(_ sender: UIButton) {
		presentColorPickerWithCompletion { [weak self] color in
			self?.tintColorView.backgroundColor = color
		}
	}

	@IBAction func selectBorderColor(_ sender: UIButton) {
		presentColorPickerWithCompletion { [weak self] color in
			self?.borderColorView.backgroundColor = color
		}
	}
}
