//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

@class LayerStyle;
@class ColorStyle;

@interface UIView (Styles)
@property (nonatomic, strong) LayerStyle *layerStyle UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) ColorStyle *colorStyle UI_APPEARANCE_SELECTOR;
- (void)applyStyle;
@end
