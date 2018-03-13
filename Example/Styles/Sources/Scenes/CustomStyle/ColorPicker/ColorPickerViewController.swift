//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

final class ColorPickerViewController: UIViewController {
	@IBOutlet weak var rLabel: UILabel!
	@IBOutlet weak var gLabel: UILabel!
	@IBOutlet weak var bLabel: UILabel!
	@IBOutlet weak var aLabel: UILabel!

	@IBOutlet weak var rValueSlider: UISlider!
	@IBOutlet weak var gValueSlider: UISlider!
	@IBOutlet weak var bValueSlider: UISlider!
	@IBOutlet weak var aValueSlider: UISlider!

	@IBOutlet weak var colorView: UIView!
	var completion: ((_ color: UIColor?) -> Void)?

	@IBAction func sliderValueChanged(_ sender: UISlider) {
		let value = Float(roundf((sender.value * 1000.0) / 1000.0))
		sender.value = value
		applyColor()
		print(value)
	}

	private func applyColor() {
		let color = UIColor(
			red: CGFloat(rValueSlider.value / 255.0),
			green: CGFloat(gValueSlider.value / 255.0),
			blue: CGFloat(bValueSlider.value / 255.0),
			alpha: CGFloat(aValueSlider.value / 255.0)
		)
		colorView.backgroundColor = color
	}

	@IBAction func apply() {
		completion?(colorView.backgroundColor)
		navigationController?.popViewController(animated: true)
	}

	static func makeInstance() -> ColorPickerViewController? {
		let storyboard = UIStoryboard(name: "ColorPicker", bundle: nil)
		guard let controller = storyboard.instantiateInitialViewController() as? ColorPickerViewController else { return nil }
		return controller
	}
}
