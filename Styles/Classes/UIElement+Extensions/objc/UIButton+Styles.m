//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UIButton+Styles.h"
#import "UIView+Styles.h"
#import <objc/runtime.h>
#import "Swizzle.h"
#import <Styles/Styles-Swift.h>

@interface UIButton ()
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, TextStyle *> *styles;
@end

@implementation UIButton (Styles)

- (void)setStyles:(NSMutableDictionary *)styles {
    objc_setAssociatedObject(self, @selector(styles), styles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)styles {
    NSMutableDictionary *stored = objc_getAssociatedObject(self, @selector(styles));
    if (!stored) {
        stored = [NSMutableDictionary new];
        [self setStyles:stored];
    }
    return stored;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzle_instance_method(class, @selector(setTitle:forState:), @selector(swizzle_setTitle:forState:));
    });
}

- (void)swizzle_setTitle:(NSString *)title forState:(UIControlState)state {
    [self swizzle_setTitle:title forState:state];
    [self applyStyle];
}

- (void)setTextStyle:(TextStyle *)style forState:(UIControlState)state {
    self.styles[@(state)] = style;
    [self applyStyle];
}

- (void)applyStyle {
    [super applyStyle];
    [self.styles enumerateKeysAndObjectsUsingBlock:^(NSNumber *stateKey, TextStyle *style, BOOL *stop) {
        UIControlState state = (UIControlState)stateKey.unsignedIntegerValue;
        [self updateTitleForState:state usingStyle:style];
    }];
}

- (void)updateTitleForState:(UIControlState)state usingStyle:(TextStyle *)style {
    NSString *title = [self titleForState:state];
    if (!title) {
        return;
    }
    [self setAttributedTitle:[style applyTo:title] forState:state];
}

@end
