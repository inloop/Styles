//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class StylePickerViewController: UITableViewController {
    var completion: ((_ pattern: TextDecoration.Style) -> Void)?
    private let cellReuseIdentifier = "style_cell"
    private let allStyles = [
        TextDecoration.Style.single,
        .double,
        .thick
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        navigationItem.title = "TextDecoration - Style"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStyles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let style = allStyles[indexPath.row]
        cell.textLabel?.text = style.codeDescription
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let style = allStyles[indexPath.row]
        completion?(style)
        navigationController?.popViewController(animated: true)
    }
}
