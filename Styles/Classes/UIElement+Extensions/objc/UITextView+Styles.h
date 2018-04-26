//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>
#import "TextInputState.h"

@class TextStyle;
@class ViewStyle;

/**
 UITextView+Styles allows you to set view and text style for particular state
 */
@interface UITextView (Styles)
/**
 Sets text style for state

 - Parameter style: The text style to be applied
 - Parameter state: The state for which should be the `style` applied

 *Note*
 It is also usable as UIAppearance selector.
 @see TextStyle for more reference
 */
- (void)setTextStyle:(TextStyle *)style forState:(TextInputState)state UI_APPEARANCE_SELECTOR;

/**
 Sets view style for particular state. Can throw an exception in case you set the style for both states and layer properties are missing.
 In particular, you have to match layer properties.
 @see ViewStyle for more information.

 - Parameter style: The view style to be applied
 - Parameter state: The state for which should be the `style` applied

 *Note*
 It is also usable as UIAppearance selector.
 @see ViewStyle for more reference
 */
- (void)setViewStyle:(ViewStyle *)style forState:(TextInputState)state UI_APPEARANCE_SELECTOR;
@end
