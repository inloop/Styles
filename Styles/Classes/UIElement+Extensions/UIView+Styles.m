//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UIView+Styles.h"
#import <Styles/Styles-Swift.h>
#import <objc/runtime.h>
#import "Swizzle.h"

@implementation UIView (Styles)

SYNTHESIZE_PROPERTY_OBJ(LayerStyle, layerStyle, LayerStyle);
SYNTHESIZE_PROPERTY_OBJ(ColorStyle, colorStyle, ColorStyle);

- (void)applyStyle {
    [self.layerStyle applyTo:self.layer];
    [self.colorStyle applyTo:self];
}

@end
