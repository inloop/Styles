//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>
#import "TextInputState.h"

@class TextStyle;
@class ViewStyle;

@interface UITextView (Styles)
- (void)setTextStyle:(TextStyle *)style forState:(TextInputState)state UI_APPEARANCE_SELECTOR;
- (void)setViewStyle:(ViewStyle *)style forState:(TextInputState)state UI_APPEARANCE_SELECTOR;
@end
