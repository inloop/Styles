//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class UIElementsViewController: UIViewController {
    fileprivate var viewStyle: ViewStyle? {
        didSet {
            guard let style = viewStyle else { return }
            textView.viewStyle = style
            textField.viewStyle = style
        }
    }
    fileprivate var textStyle: TextStyle? {
        didSet {
            guard let style = textStyle else { return }
            [TextInputState.editing , .inactive].forEach {
                textView.setTextStyle(style, for: $0)
                textField.setTextStyle(style, for: $0)
            }
        }
    }

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let controller as DefineViewStyleViewController:
            controller.delegate = self
        case let controller as DefineTextStyleViewController:
            controller.delegate = self
        default:
            break
        }
    }

    @IBAction func resignFirstResponder(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
        textView.resignFirstResponder()
    }
}

extension 	UIElementsViewController: StylePickerDelegate {
    func didPickTextStyleDefinition(_ definition: TextStyle.Definition) {
        textStyle = definition.textStyle
    }

    func didPickViewStyleDefinition(_ definition: ViewStyle.Definition) {
        viewStyle = definition.viewStyle
    }
}
