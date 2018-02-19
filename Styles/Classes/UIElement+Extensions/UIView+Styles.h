//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

@class ViewStyle;

@interface UIView (Styles)
@property (nonatomic, copy) ViewStyle *viewStyle UI_APPEARANCE_SELECTOR;
- (void)applyStyle;
@end
