//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

@class TextStyle;

@interface UIButton (Styles)
- (void)setTextStyle:(TextStyle *)style forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
@end
