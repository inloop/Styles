//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UITextField+Styles.h"
#import <objc/runtime.h>
#import "Swizzle.h"
#import "UIView+Styles.h"
#import <Styles/Styles-Swift.h>

@interface UITextField ()
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, TextStyle *> *textStyles;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, ViewStyle *> *viewStyles;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, TextStyle *> *placeholderStyles;
@end

@implementation UITextField (Styles)

- (NSMutableDictionary *)textStyles {
    NSMutableDictionary *stored = objc_getAssociatedObject(self, @selector(textStyles));
    if (!stored) {
        stored = [NSMutableDictionary new];
        [self setTextStyles:stored];
    }
    return stored;
}

- (NSMutableDictionary *)viewStyles {
    NSMutableDictionary *stored = objc_getAssociatedObject(self, @selector(viewStyles));
    if (!stored) {
        stored = [NSMutableDictionary new];
        [self setViewStyles:stored];
    }
    return stored;
}

- (NSMutableDictionary *)placeholderStyles {
    NSMutableDictionary *stored = objc_getAssociatedObject(self, @selector(placeholderStyles));
    if (!stored) {
        stored = [NSMutableDictionary new];
        [self setPlaceholderStyles:stored];
    }
    return stored;
}

- (void)setViewStyles:(NSMutableDictionary *)viewStyles {
    objc_setAssociatedObject(self, @selector(viewStyles), viewStyles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTextStyles:(NSMutableDictionary *)textStyles {
    objc_setAssociatedObject(self, @selector(textStyles), textStyles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPlaceholderStyles:(NSMutableDictionary *)placeholderStyles {
    objc_setAssociatedObject(self, @selector(placeholderStyles), placeholderStyles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzle_instance_method(class, @selector(becomeFirstResponder), @selector(swizzle_becomeFirstResponder));
        swizzle_instance_method(class, @selector(resignFirstResponder), @selector(swizzle_resignFirstResponder));
        swizzle_instance_method(class, @selector(awakeFromNib), @selector(swizzle_awakeFromNib));
    });
}

- (BOOL)swizzle_becomeFirstResponder {
    BOOL isFirstResponder = [self swizzle_becomeFirstResponder];
    [self updateStylesForState:kEditing];
    return isFirstResponder;
}

- (BOOL)swizzle_resignFirstResponder {
    BOOL didResignFirstResponder = [self swizzle_resignFirstResponder];
    [self updateStylesForState:kInactive];
    return didResignFirstResponder;
}

- (void)swizzle_awakeFromNib {
    [self swizzle_awakeFromNib];
    [self addTarget:self
             action:@selector(applyStyleForCurrentState)
   forControlEvents:UIControlEventEditingChanged];
}

- (void)setTextStyle:(TextStyle *)style forState:(TextInputState)state {
    self.textStyles[@(state)] = style;
    [self applyStyleForCurrentState];
}

- (void)setViewStyle:(ViewStyle *)style forState:(TextInputState)state {
    self.viewStyles[@(state)] = style;
    [self applyStyleForCurrentState];
}

- (void)setPlaceholderStyle:(TextStyle *)style forState:(TextInputState)state {
    self.placeholderStyles[@(state)] = style;
    [self applyStyleForCurrentState];
}

- (void)applyStyleForCurrentState {
    [self checkEqualLayerInStyles];
    [self applyStyle];
    TextInputState state = [self isEditing] ? kEditing : kInactive;
    [self updateStylesForState:state];
}

- (void)checkEqualLayerInStyles {
    ViewStyle *editing = self.viewStyles[@(kEditing)];
    ViewStyle *inactive = self.viewStyles[@(kInactive)];

    if (editing == nil || inactive == nil) {
        return;
    }

    NSError *error = nil;

    [editing hasEqualLayerProperties:inactive error:&error];

    if (error) {
        NSAssert(NO, @"Invalid layer configuration for %@. %@", [self class], [error localizedDescription]);
    }
}


- (void)updateStylesForState:(TextInputState)state {
    ViewStyle *viewSyle = self.viewStyles[@(state)];
    TextStyle *textStyle = self.textStyles[@(state)];
    TextStyle *placeholderStyle = self.placeholderStyles[@(state)];

    [self applyTextStyle:textStyle];
    [self applyViewStyle:viewSyle];
    [self applyPlaceholderStyle:placeholderStyle];
}

- (void)applyTextStyle:(TextStyle *)style {
    NSDictionary *attributes = [style attributes];

    if (!attributes) {
        return;
    }

    [self setDefaultTextAttributes:attributes];
}

- (void)applyViewStyle:(ViewStyle *)style {
    if (!style) {
        return;
    }
    [style applyTo:self];
}

- (void)applyPlaceholderStyle:(TextStyle *)style {
    NSString *placeholder = self.placeholder;
    if (!placeholder || !style) {
        return;
    }
    self.attributedPlaceholder = [style applyTo:placeholder];
}

@end
