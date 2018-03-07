//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UIView+Styles.h"
#import <Styles/Styles-Swift.h>
#import <objc/runtime.h>
#import "Swizzle.h"

@implementation UIView (Styles)

SYNTHESIZE_PROPERTY_OBJ(ViewStyle, viewStyle, ViewStyle);

- (void)applyStyle {
    [self.viewStyle applyTo:self];
}

@end
