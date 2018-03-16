//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class MatchPickerViewController: UIViewController {
	private let allowedMatches = [".block, .first, .regex"]
	private var matchDefinition: MatchDefinition!

	@IBOutlet weak var matchSegmentControl: UISegmentedControl!
	@IBOutlet weak var matchOccurenceTextView: UITextView!

	var completion: ((_ mathcDefinition: MatchDefinition) -> Void)?

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Select match"
		setupMatch()
	}

	@IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
		matchOccurenceTextView.resignFirstResponder()
	}

	@IBAction func applyAndExit(_ sender: UIButton) {
		setupMatch()
		navigationController?.popViewController(animated: true)
		completion?(matchDefinition)
	}

	private func setupMatch() {
		switch matchSegmentControl.selectedSegmentIndex {
		case 0: makeBlockMatch()
		case 1: makeFirstMatch()
		case 2:	makeRegexMatch()
		default: break
		}
	}

	private func makeBlockMatch() {
		let text = matchOccurenceTextView.text ?? ""
		let match = Block { $0.range(of: text) }
		let matchDescription = "Block { $0.range(of: \"\(text)\") }"
		matchDefinition = MatchDefinition(match: match, matchDescription: matchDescription)
	}

	private func makeFirstMatch() {
		let text = matchOccurenceTextView.text ?? ""
		let match = First(occurenceOf: text)
		let matchDescription = "First(occurenceOf: \"\(text)\")"
		matchDefinition = MatchDefinition(match: match, matchDescription: matchDescription)
	}

	private func makeRegexMatch() {
		let text = matchOccurenceTextView.text ?? ""
		let match = Regex(text)
		let matchDescription = "Regex(\"\(text)\")"
		matchDefinition = MatchDefinition(match: match, matchDescription: matchDescription)
	}
}
