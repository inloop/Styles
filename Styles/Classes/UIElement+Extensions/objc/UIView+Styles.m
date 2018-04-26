//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UIView+Styles.h"
#import <Styles/Styles-Swift.h>
#import <objc/runtime.h>
#import "Swizzle.h"

@implementation UIView (Styles)

SYNTHESIZE_PROPERTY_OBJ(ViewStyle, _viewStyle, _viewStyle);

- (void)_applyStyle {
    [self._viewStyle applyTo:self];
}

@end
