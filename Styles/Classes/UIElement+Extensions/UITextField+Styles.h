//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UITextFieldState) {
    kEditing,
    kInactive,
};

@class TextStyle;
@class LayerStyle;

@interface UITextField (Styles)
- (void)setTextStyle:(TextStyle *)style forState:(UITextFieldState)state UI_APPEARANCE_SELECTOR;
- (void)setLayerStyle:(LayerStyle *)style forState:(UITextFieldState)state UI_APPEARANCE_SELECTOR;
@end
