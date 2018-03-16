//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit

protocol FontPickerDelegate: class {
	func didPickFontWithName(_ fontName: String)
}

final class FontPickerViewController: UITableViewController {
	private let fontCellReuseIdentifier = "font_cell"
	weak var delegate: FontPickerDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Font families"
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: fontCellReuseIdentifier)
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return UIFont.familyNames.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: fontCellReuseIdentifier, for: indexPath)
		cell.textLabel?.text = UIFont.familyNames[indexPath.row]
		cell.accessoryType = .disclosureIndicator
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		showFontNamePicker(UIFont.familyNames[indexPath.row])
	}

	private func showFontNamePicker(_ fontFamilyName: String) {
		guard UIFont.fontNames(forFamilyName: fontFamilyName).count > 0 else {
			didPickFontWithName(fontFamilyName)
			return
		}
		let controller = FontNamePickerViewController()
		controller.delegate = self
		controller.fontName = fontFamilyName
		navigationController?.pushViewController(controller, animated: true)
	}
}

extension FontPickerViewController: FontPickerDelegate {
	func didPickFontWithName(_ fontName: String) {
		navigationController?.popViewController(animated: true)
		delegate?.didPickFontWithName(fontName)
	}
}

final class FontNamePickerViewController: UITableViewController {
	private let fontCellReuseIdentifier = "font_name_cell"
	var fontName: String!
	weak var delegate: FontPickerDelegate?

	lazy var fonts = UIFont.fontNames(forFamilyName: fontName)

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "\(fontName!) options"
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: fontCellReuseIdentifier)
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return fonts.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: fontCellReuseIdentifier, for: indexPath)
		cell.textLabel?.text = fonts[indexPath.row]
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		delegate?.didPickFontWithName(fonts[indexPath.row])
	}
}
