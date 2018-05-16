//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation
import Styles

final class GalleryViewController: UITableViewController {
    struct ViewModel {
        enum StyleType {
            case view(ViewStyle.Definition)
            case text(TextStyle.Definition)
        }

        let items: [[StyleType]]
    }

    private let viewModel = ViewModel(items: [
        [.view(.rounded),
         .view(.appColor),
         .view(.redColor),
         .view(.red),
         .view(.blue),
         .view(.roundedApp)
        ],
        [.text(.h1),
         .text(.body),
         .text(.highlight),
         .text(.bigRed),
         .text(.bigGreen),
         .text(.cyanTextWithBlueShadow),
         .text(.styleWithEffects),
         .text(.greenHeadline),
         .text(.magentaFootnote),
         .text(.largeTitle),
         .text(.blueFootnote)
        ]
        ])

    private let sectionTitles =  ["ViewStyles", "TextStyles"]

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.navigationItem.title = "Styles ❤️"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.items[indexPath.section][indexPath.row]
        let cell: UITableViewCell
        switch model {
        case .view(let definition):
            let viewStyleCell = tableView.dequeueReusableCell(withIdentifier: "ViewStyleCell", for: indexPath) as! ViewStyleCell
            viewStyleCell.setModel(ViewStyleCell.ViewModel(viewStyle: definition.viewStyle, styleDefinition: definition.styleDescription))
            cell = viewStyleCell
        case .text(let definition):
            let textStyleCell = tableView.dequeueReusableCell(withIdentifier: "TextStyleCell", for: indexPath) as! TextStyleCell
            textStyleCell.setModel(TextStyleCell.ViewModel(
                textStyle: definition.textStyle,
                stylesDefinition: definition.styleDescription)
            )
            cell = textStyleCell
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.viewStyle = .appColor
        label.textStyle = .h1
        label.text = sectionTitles[section]
        label.sizeToFit()
        return label
    }
}
