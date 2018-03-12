//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

extension Bool {
    mutating func toggle() {
        self = !self
    }
}

final class ExLabel: UILabel { }
final class ExButton: UIButton { }

final class ViewController: UIViewController {
    @IBOutlet var label: ExLabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var textField: UITextField!
    @IBOutlet var containerView: UIView!
    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.viewStyle = redColor
        label.text = "Styles is awesome!"
    }

    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }

    @IBAction func handleButtonAction(_ sender: UIButton) {
        navigationController?.navigationBar.prefersLargeTitles.toggle()
    }
}

