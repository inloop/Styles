//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

extension Bool {
    mutating func toggle() {
        self = !self
    }
}

final class ExLabel: UILabel { }

final class ViewController: UIViewController {
    @IBOutlet var label: ExLabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var containerView: UIView!

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

