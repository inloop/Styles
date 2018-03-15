//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

protocol ShadowPickerDelegate: class {
	func didPickShadow(_ definition: Shadow.ShadowDefinition)
}

final class ShadowViewController: UIViewController {
	@IBOutlet weak var colorView: UIView!
	@IBOutlet weak var shadowView: UIView!
	@IBOutlet weak var radiusLabel: UILabel!
	@IBOutlet weak var radiusSlider: UISlider!
	@IBOutlet weak var horizontalOffsetLabel: UILabel!
	@IBOutlet weak var horizontalOffsetSlider: UISlider!

	@IBOutlet weak var verticalOffsetLabel: UILabel!
	@IBOutlet weak var verticalOffsetSlider: UISlider!
	@IBOutlet weak var opacityLabel: UILabel!
	@IBOutlet weak var opacitySlider: UISlider!
	@IBOutlet weak var rasterizeSwitch: UISwitch!
	@IBOutlet weak var rasterizationScaleLabel: UILabel!
	@IBOutlet weak var rasterizationScaleSlider: UISlider!

	var shadow = Shadow.none
	weak var delegate: ShadowPickerDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Define shadow"
	}

	@IBAction func sliderValueChanged(_ sender: UISlider) {
		let value = roundf(sender.value)
		sender.value = value

		switch sender.tag {
		case verticalOffsetSlider.tag:
			verticalOffsetLabel.text = "Vertical offset \(value)"
		case horizontalOffsetSlider.tag:
			horizontalOffsetLabel.text = "Horizontal offset \(value)"
		case opacitySlider.tag:
			opacityLabel.text = "Opacity \(value / 100.0)"
		case radiusSlider.tag:
			radiusLabel.text = "Radius \(value)"
		case rasterizationScaleSlider.tag:
			rasterizationScaleLabel.text = "RasterizationScale \(value)"
		default: break
		}

		renderShadow()
	}

	@IBAction func shouldRasterize() {
		renderShadow()
	}

	@IBAction func applyAndExit() {
		let shadowDescription =
		"""
		let shadow = Shadow(
			color: \((colorView.backgroundColor ?? .black).debugDescription),
			offset: UIOffset(
				horizontal: \(CGFloat(horizontalOffsetSlider.value)),
				vertical: \(CGFloat(verticalOffsetSlider.value))
			),
			radius: \(CGFloat(radiusSlider.value)),
			opacity: \(opacitySlider.value / 100.0),
			shouldRasterizeLayer: \(rasterizeSwitch.isOn),
			rasterizationScale: \(CGFloat(rasterizationScaleSlider.value))
		)
		"""
		delegate?.didPickShadow(Shadow.ShadowDefinition(shadow: shadow, shadowDescription: shadowDescription))
		navigationController?.popViewController(animated: true)
	}

	@IBAction func selectColor() {
		guard let controller = ColorPickerViewController.makeInstance() else { return }
		controller.completion = { [weak self] color in
			self?.colorView.backgroundColor = color
			self?.renderShadow()
		}
		self.navigationController?.pushViewController(controller, animated: true)
	}

	private func renderShadow() {
		shadow = Shadow(
			color: colorView.backgroundColor ?? .black,
			offset: UIOffset(
				horizontal: CGFloat(horizontalOffsetSlider.value),
				vertical: CGFloat(verticalOffsetSlider.value)
			),
			radius: CGFloat(radiusSlider.value),
			opacity: opacitySlider.value / 100.0,
			shouldRasterizeLayer: rasterizeSwitch.isOn,
			rasterizationScale: CGFloat(rasterizationScaleSlider.value)
		)
		let style = ViewStyle(.shadow(shadow))
		shadowView.viewStyle = style
	}
}
