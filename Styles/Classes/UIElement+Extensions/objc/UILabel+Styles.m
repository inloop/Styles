//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UILabel+Styles.h"
#import "UIView+Styles.h"
#import <Styles/Styles-Swift.h>
#import <objc/runtime.h>
#import "Swizzle.h"

@implementation UILabel (Styles)

SYNTHESIZE_PROPERTY_OBJ(TextStyle, textStyle, TextStyle);

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzle_instance_method(class, @selector(setText:), @selector(swizzle_setText:));
    });
}

- (void)applyStyle {
    [super applyStyle];
    [self updateText];
}

- (void)swizzle_setText:(NSString *)text {
    [self swizzle_setText:text];
    [self updateText];
}

- (void)updateText {
    if (!self.attributedText.string || !self.textStyle) {
        return;
    }
    self.attributedText = [self.textStyle applyTo:self.attributedText.string];
}

@end
