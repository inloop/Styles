//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

class ExLabel: UILabel {

}

class ViewController: UIViewController {
    @IBOutlet var label: ExLabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Styles is awesome!"
//        button.setTitle("Default", for: .normal)
//        button.setTitle("Highlighted", for: .highlighted)
    }
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}

