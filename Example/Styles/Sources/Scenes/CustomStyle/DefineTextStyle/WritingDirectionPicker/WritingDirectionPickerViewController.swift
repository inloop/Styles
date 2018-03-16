//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class WritingDirectionPickerViewController: UITableViewController {
	var selectedWritingDirectionOverrides = [TextStyle.WritingDirectionOverride]()
	private let allOverrides = [
		TextStyle.WritingDirectionOverride.leftToRightEmbedding,
		.leftToRightOverride,
		.rightToLeftOverride,
		.rightToLeftEmbedding
	]
	private let cellIdentifier = "writing_direction_cell"

	var completion: ((_ overrides: [TextStyle.WritingDirectionOverride]) -> Void)?

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UITableViewCell.self
			, forCellReuseIdentifier: cellIdentifier)
		navigationItem.title = "Writing direction override"
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(apply))
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allOverrides.count
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let override = allOverrides[indexPath.row]
		let cell = tableView.cellForRow(at: indexPath)
		if let index = selectedWritingDirectionOverrides.index(of: override) {
			selectedWritingDirectionOverrides.remove(at: index)
			cell?.accessoryType = .none
		} else {
			selectedWritingDirectionOverrides.append(override)
			cell?.accessoryType = .checkmark
		}
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
		let override = allOverrides[indexPath.row]
		cell.accessoryType = selectedWritingDirectionOverrides.contains(override)
			? .checkmark
			: .none
		cell.textLabel?.text = override.description
		return cell
	}

	@objc func apply() {
		navigationController?.popViewController(animated: true)
		completion?(selectedWritingDirectionOverrides)
	}
}
