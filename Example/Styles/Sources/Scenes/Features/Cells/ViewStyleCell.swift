//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit
import Styles

final class ViewStyleCell: UITableViewCell {
    struct ViewModel {
        let viewStyle: ViewStyle
        let styleDefinition: String
    }

    @IBOutlet private weak var stylingView: UIView!
    @IBOutlet private weak var styleDescriptionLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        viewStyle = ViewStyle()
    }
    
    func setModel(_ model: ViewModel) {
        stylingView.viewStyle = model.viewStyle
        styleDescriptionLabel.text = model.styleDefinition
    }
}
