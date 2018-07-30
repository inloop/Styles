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

private extension ViewStyle {
    static let normal = ViewStyle(.backgroundColor(.red))
    static let selected = ViewStyle(.backgroundColor(.green))
}

final class TestBedViewController: UIViewController {
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var button: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        textField.setTextStyle(.active, for: .editing)
        textField.setTextStyle(.inactive, for: .inactive)

        print("setting ViewStyle for .normal")
        button.setViewStyle(.normal, for: .normal)

        print("setting ViewStyle for .highlighted")
        button.setViewStyle(.selected, for: .highlighted)

        print("setting TextStyle for .normal")
        button.setTextStyle(.active, for: .normal)

        print("setting TextStyle for .highlighted")
        button.setTextStyle(.inactive, for: .highlighted)

    }

    @objc private func animationDidStop(_ note: Notification) {
        print(#function, note)
    }

    @IBAction func cancelEditing() {
        textField.resignFirstResponder()
    }
}
