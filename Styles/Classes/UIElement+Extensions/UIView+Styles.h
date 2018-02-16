//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

@class LayerStyle;
@class ColorStyle;

@interface UIView (Styles)
@property (nonatomic, copy) LayerStyle *layerStyle UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) ColorStyle *colorStyle UI_APPEARANCE_SELECTOR;
- (void)applyStyle;
@end
