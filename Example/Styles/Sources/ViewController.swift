//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

class ExLabel: UILabel {

}

class ViewController: UIViewController {
    @IBOutlet var label: ExLabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.colorStyle = redColor
        label.text = "Styles is awesome!"
//        button.setTitle("Default", for: .normal)
//        button.setTitle("Highlighted", for: .highlighted)
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}

