//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UIButton+Styles.h"
#import "UIView+Styles.h"
#import <objc/runtime.h>
#import "Swizzle.h"
#import <Styles/Styles-Swift.h>

@interface UIButton ()
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, TextStyle *> *textStyles;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, ViewStyle *> *viewStyles;
@property (assign) UIControlState _styles_previousControlState;
@end

@implementation UIButton (Styles)

- (void)setTextStyles:(NSMutableDictionary *)styles {
    objc_setAssociatedObject(self, @selector(textStyles), styles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)textStyles {
    NSMutableDictionary *stored = objc_getAssociatedObject(self, @selector(textStyles));
    if (!stored) {
        stored = [NSMutableDictionary new];
        [self setTextStyles:stored];
    }
    return stored;
}

- (void)setViewStyles:(NSMutableDictionary *)styles {
    objc_setAssociatedObject(self, @selector(viewStyles), styles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)viewStyles {
    NSMutableDictionary *stored = objc_getAssociatedObject(self, @selector(viewStyles));
    if (!stored) {
        stored = [NSMutableDictionary new];
        [self setViewStyles:stored];
    }
    return stored;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzle_instance_method(class, @selector(setTitle:forState:), @selector(swizzle_setTitle:forState:));
        swizzle_instance_method(class, @selector(touchesBegan:withEvent:), @selector(swizzle_touchesBegan:withEvent:));
        swizzle_instance_method(class, @selector(touchesMoved:withEvent:), @selector(swizzle_touchesMoved:withEvent:));
        swizzle_instance_method(class, @selector(touchesEnded:withEvent:), @selector(swizzle_touchesEnded:withEvent:));
        swizzle_instance_method(class, @selector(touchesCancelled:withEvent:), @selector(swizzle_touchesCancelled:withEvent:));
        swizzle_instance_method(class, @selector(setEnabled:), @selector(swizzle_setEnabled:));
        swizzle_instance_method(class, @selector(setSelected:), @selector(swizzle_setSelected:));
        swizzle_instance_method(class, @selector(setHighlighted:), @selector(swizzle_setHighlighted:));
        swizzle_instance_method(class, @selector(didMoveToSuperview), @selector(swizzle_didMoveToSuperview));
        swizzle_instance_method(class, @selector(didMoveToWindow), @selector(swizzle_didMoveToWindow));
    });
}

- (void)swizzle_setTitle:(NSString *)title forState:(UIControlState)state {
    [self swizzle_setTitle:title forState:state];
    [self applyStyle];
}

- (void)setTextStyle:(TextStyle *)style forState:(UIControlState)state {
    self.textStyles[@(state)] = style;
    [self applyStyle];
}

- (void)applyStyle {
    [super applyStyle];
    [self.textStyles enumerateKeysAndObjectsUsingBlock:^(NSNumber *stateKey, TextStyle *style, BOOL *stop) {
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

#pragma mark - State update

- (void)setViewStyle:(ViewStyle *)style forState:(UIControlState)state {
    self.viewStyles[@(state)] = style;
    [self checkState];
}

- (UIControlState)_styles_previousControlState {
    UIControlState prevState = [(NSNumber *)objc_getAssociatedObject(self, @selector(_styles_previousControlState)) unsignedIntegerValue];
    return prevState;
}

- (void)set_styles_previousControlState:(UIControlState)state {
    objc_setAssociatedObject(self, @selector(_styles_previousControlState), @(state), OBJC_ASSOCIATION_RETAIN);
}

- (void)swizzle_didMoveToSuperview {
    [self swizzle_didMoveToSuperview];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.viewStyle = self.viewStyles[@(self.state)];
    [self applyStyle];
}

- (void)swizzle_didMoveToWindow {
    [self swizzle_didMoveToWindow];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.viewStyle = self.viewStyles[@(self.state)];
    [self applyStyle];
}

- (void)swizzle_setEnabled:(BOOL)enabled {
    self._styles_previousControlState = self.state;
    [self swizzle_setEnabled:enabled];
    [self checkState];
}

- (void)swizzle_setSelected:(BOOL)selected {
    self._styles_previousControlState = self.state;
    [self swizzle_setSelected:selected];
    [self checkState];
}

- (void)swizzle_setHighlighted:(BOOL)highlighted {
    self._styles_previousControlState = self.state;
    [self swizzle_setHighlighted:highlighted];
    [self checkState];
}

- (void)swizzle_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self._styles_previousControlState = self.state;
    [self swizzle_touchesBegan:touches withEvent:event];
    [self checkState];
}

- (void)swizzle_touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self._styles_previousControlState = self.state;
    [self swizzle_touchesMoved:touches withEvent:event];
    [self checkState];
}

- (void)swizzle_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self._styles_previousControlState = self.state;
    [self swizzle_touchesEnded:touches withEvent:event];
    [self checkState];
}

- (void)swizzle_touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self._styles_previousControlState = self.state;
    [self swizzle_touchesCancelled:touches withEvent:event];
    [self checkState];
}

- (void)checkState {
    NSLog(@"Checking state prev = %ld, now = %ld", self._styles_previousControlState, self.state);
    if (self._styles_previousControlState == self.state) {
        return;
    }

    self._styles_previousControlState = self.state;

    NSLog(@"stored styles = %@", self.viewStyles);

    [self.viewStyles enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, ViewStyle * _Nonnull obj, BOOL * _Nonnull stop) {
        UIControlState keyState = key.unsignedIntegerValue;

        if (self.state == keyState) {
            NSLog(@"applying state");
            self.viewStyle = obj;
            [self applyStyle];
        }
    }];
}

@end
