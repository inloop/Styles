//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

private extension TextStyle {
    static let active = TextStyle(
        .font(UIFont.systemFont(ofSize: 23)),
        .foregroundColor(.yellow)
    )

    static let inactive = TextStyle(
        .font(UIFont.systemFont(ofSize: 13)),
        .foregroundColor(.blue)
    )
}

private extension UIColor {
    var image: UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(cgColor)
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

private extension ViewStyle {
    static let normal = ViewStyle(.backgroundColor(.red))
    static let selected = ViewStyle(.backgroundColor(.green))
}

final class TestBedViewController: UIViewController {
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var button: UIButton!
    @IBOutlet private var plainButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupButton()
        setupPlainButton()
    }

    private func setupTextField() {
        textField.setTextStyle(.active, for: .editing)
        textField.setTextStyle(.inactive, for: .inactive)
    }

    private func setupButton() {
        print("setting ViewStyle for .normal")
        button.setViewStyle(.normal, for: .normal)

        print("setting ViewStyle for .highlighted")
        button.setViewStyle(.selected, for: .highlighted)

        print("setting TextStyle for .normal")
        button.setTextStyle(.active, for: .normal)

        print("setting TextStyle for .highlighted")
        button.setTextStyle(.inactive, for: .highlighted)
    }

    private func setupPlainButton() {
        plainButton.setBackgroundImage(UIColor.red.image, for: .normal)
        plainButton.setBackgroundImage(UIColor.green.image, for: .highlighted)
        let title = "Plain System Button"
        plainButton.setAttributedTitle(
            TextStyle.active.apply(to: title),
            for: .normal
        )
        plainButton.setAttributedTitle(
            TextStyle.inactive.apply(to: title),
            for: .highlighted
        )
    }

    @objc private func animationDidStop(_ note: Notification) {
        print(#function, note)
    }

    @IBAction func cancelEditing() {
        textField.resignFirstResponder()
    }
}
