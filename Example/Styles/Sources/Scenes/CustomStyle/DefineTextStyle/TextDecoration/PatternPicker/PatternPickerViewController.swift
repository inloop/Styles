//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class PatternPickerViewController: UITableViewController {
    var completion: ((_ pattern: TextDecoration.Pattern) -> Void)?
    private let cellReuseIdentifier = "pattern_cell"
    private let allPatterns = [
        TextDecoration.Pattern.dot,
        .dash,
        .dashDot,
        .dashDotDot
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        navigationItem.title = "TextDecoration - Pattern"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPatterns.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let pattern = allPatterns[indexPath.row]
        cell.textLabel?.text = pattern.codeDescription
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pattern = allPatterns[indexPath.row]
        completion?(pattern)
        navigationController?.popViewController(animated: true)
    }
}
