//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UIView+Styles.h"
#import <Styles/Styles-Swift.h>
#import <objc/runtime.h>
#import "Swizzle.h"

@implementation UIView (Styles)

SYNTHESIZE_PROPERTY_OBJ(ViewStyle, viewStyle, ViewStyle);

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzle_instance_method(class, @selector(layoutSubviews), @selector(swizzle_layoutSubviews));
    });
}

- (void)swizzle_layoutSubviews {
    [self swizzle_layoutSubviews];
    [self.viewStyle applyLayoutTo:self];
}

- (void)applyStyle {
    [self.viewStyle applyTo:self];
}

@end
