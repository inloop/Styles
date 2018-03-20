//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

@class ViewStyle;

/**
 UIView+Styles allows to set and apply view style not only on particular instance but also globally as UIAppearance selector.
 */
@interface UIView (Styles)
/// ViewStyle to be applied to the view
@property (nonatomic, copy) ViewStyle *viewStyle UI_APPEARANCE_SELECTOR;
/**
 Applies the style to view
 */
- (void)applyStyle;
@end
