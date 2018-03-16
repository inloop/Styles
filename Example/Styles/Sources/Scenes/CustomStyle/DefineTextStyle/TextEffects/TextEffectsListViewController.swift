//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Styles

final class TextEffectsListViewController: UITableViewController {
    private let reuseIdentifier = "text_effect_cell"
    var textEffects = [TextEffect.Definition]()

    var completion: ((_ effects: [TextEffect.Definition]) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Text effects"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(addTextEffect)
            ),
            UIBarButtonItem(
                barButtonSystemItem: .done,
                target: self,
                action: #selector(finishAndClose)
            )
        ]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textEffects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        let effect = textEffects[indexPath.row]
        cell.textLabel?.text = effect.effectDescription + "\n" + effect.textStyleDescription
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let effect = textEffects[indexPath.row]
        let alert = UIAlertController(title: "Remove Effect?", message: "Do you want to remove this effect?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] _ in
            guard let index = self?.textEffects.index(where: { $0.effect == effect.effect }) else { return }
            self?.textEffects.remove(at: index)
            self?.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @objc private func addTextEffect() {
        let storyboard = UIStoryboard(name: "TextEffects", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? TextEffectsViewController else { return }
        controller.completion = { [weak self] definition in
            self?.textEffects.append(definition)
            self?.tableView.reloadData()
        }
        controller.effectsCount = textEffects.count
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc private func finishAndClose() {
        completion?(textEffects)
        navigationController?.popViewController(animated: true)
    }
}
