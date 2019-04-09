//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class TestBedViewController: UIViewController {
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var textView: UITextView!

    let active = TextStyle(
        .font(UIFont.systemFont(ofSize: 23)),
        .foregroundColor(.red)
    )

    let inactive = TextStyle(
        .font(UIFont.systemFont(ofSize: 13)),
        .foregroundColor(.blue)
    )

    let base = TextStyle(
        .font(.preferredFont(forTextStyle: .body)),
        .foregroundColor(.darkText)
    )

    let link = TextStyle(
        .foregroundColor(.red),
        .underline(TextDecoration(style: .single, pattern: .solid, byWord: false))
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        styleTextField()
        styleTextView()
    }

    func styleTextField() {
        textField.setTextStyle(active, for: .editing)
        textField.setTextStyle(inactive, for: .inactive)
    }

    func styleTextView() {
        textView.isEditable = false
        textView.isSelectable = true
        textView.text = "Donec dignissim felis vel ullamcorper sodales. Integer mauris magna, euismod sit amet pellentesque tempus, feugiat sed augue. Fusce at purus eu tellus aliquam sagittis non ut enim. Fusce id purus ultricies, euismod lorem vel, gravida elit. CLICK ME volutpat mi turpis, in auctor orci imperdiet eget. Curabitur malesuada viverra urna vitae maximus. In nec nunc ut nulla consequat fringilla eu non odio. Cras dictum magna lorem. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla non sem id eros pretium ornare nec nec lacus. Ut porta turpis iaculis metus viverra fermentum."
        let url = URL(string: "https://github.com/inloop/Styles")!
        let linkEffect = TextEffect.link(url, link, First(occurenceOf: "CLICK ME"))
        let baseWithLink = base.appending(linkEffect)
        textView.setTextStyle(baseWithLink, for: .inactive)
    }

    @IBAction func cancelEditing() {
        textField.resignFirstResponder()
    }
}

extension TestBedViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
}
