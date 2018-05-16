//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class TestBedViewController: UIViewController {
    @IBOutlet private var textField: UITextField!

    let active = TextStyle(
        .font(UIFont.systemFont(ofSize: 23)),
        .foregroundColor(.red)
    )

    let inactive = TextStyle(
        .font(UIFont.systemFont(ofSize: 13)),
        .foregroundColor(.blue)
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        textField.setTextStyle(active, for: .editing)
        textField.setTextStyle(inactive, for: .inactive)
    }

    @IBAction func cancelEditing() {
        textField.resignFirstResponder()
    }
}
