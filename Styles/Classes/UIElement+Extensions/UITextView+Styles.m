// Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UITextView+Styles.h"
#import <objc/runtime.h>
#import "Swizzle.h"
#import "UIView+Styles.h"
#import <Styles/Styles-Swift.h>

@interface UITextView ()
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, TextStyle *> *textStyles;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, ViewStyle *> *viewStyles;
@end

@implementation UITextView (Styles)

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

- (void)setViewStyles:(NSMutableDictionary *)viewStyles {
    objc_setAssociatedObject(self, @selector(viewStyles), viewStyles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTextStyles:(NSMutableDictionary *)textStyles {
    objc_setAssociatedObject(self, @selector(textStyles), textStyles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    [self applyStylesForState:kEditing];
    return [self swizzle_becomeFirstResponder];
}

- (BOOL)swizzle_resignFirstResponder {
    [self applyStylesForState:kInactive];
    return [self swizzle_resignFirstResponder];
}

- (void)swizzle_awakeFromNib {
    [self swizzle_awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewEditingDidChange:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewEditingDidChange:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:nil];
}

- (void)setTextStyle:(TextStyle *)style forState:(TextInputState)state {
    self.textStyles[@(state)] = style;
    [self applyStylesForCurrentState];
}

- (void)setViewStyle:(ViewStyle *)style forState:(TextInputState)state {
    self.viewStyles[@(state)] = style;
    [self applyStylesForCurrentState];
}

- (void)applyStylesForState:(TextInputState)state {
    ViewStyle *viewSyle = self.viewStyles[@(state)];
    TextStyle *textStyle = self.textStyles[@(state)];

    [self checkEqualLayerInStyles];
    [self applyTextStyle:textStyle];
    [self applyViewStyle:viewSyle];
}

- (void)applyStylesForCurrentState {
    TextInputState state = self.isFirstResponder ? kEditing : kInactive;
    [self applyStyle];
    [self applyStylesForState:state];
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

- (void)textViewEditingDidChange:(NSNotification *)notification {
    if (notification.object != self) {
        return;
    }
    TextInputState state = notification.name == UITextViewTextDidBeginEditingNotification ? kEditing : kInactive;
    [self applyStyle];
    [self applyStylesForState:state];
}

- (void)applyTextStyle:(TextStyle *)style {
    NSString *text = self.text;
    if (!text || !style) {
        return;
    }
    
    UITextRange *range = self.selectedTextRange;
    [self setAttributedText:[style applyTo:text]];
    if (range) {
        self.selectedTextRange = range;
    }
}

- (void)applyViewStyle:(ViewStyle *)style {
    if (!style) {
        return;
    }
    [style applyTo:self];
}

@end
