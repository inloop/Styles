//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit
import Styles

final class TextStyleCell: UITableViewCell {
	struct ViewModel {
		let textStyle: TextStyle
		let stylesDefinition: String
	}

	@IBOutlet private weak var stylingView: UILabel!
	@IBOutlet private weak var styleDescriptionLabel: UILabel!

	func setModel(_ model: ViewModel) {
		stylingView.textStyle = model.textStyle
		styleDescriptionLabel.text = model.stylesDefinition
	}
}
