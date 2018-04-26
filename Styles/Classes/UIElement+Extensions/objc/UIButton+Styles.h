//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

@class TextStyle;

/**
 UIButton+Styles allows to set the text style for particular state
 */
@interface UIButton (Styles)
/**
 Sets and applies the text style

 - Parameter style: The text style to be applied
 - Parameter state: The state for which should be the `style` applied

 *Note*
 It is also usable as UIAppearance selector.
 @see TextStyle for more reference
 */
- (void)setTextStyle:(TextStyle *)style forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
@end
