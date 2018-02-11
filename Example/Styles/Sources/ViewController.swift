//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

class ExLabel: UILabel {

}

class ViewController: UIViewController {
    @IBOutlet var label: ExLabel!
    @IBOutlet var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Toto je zlee"
//        button.setTitle("Default", for: .normal)
//        button.setTitle("Highlighted", for: .highlighted)
    }
}

