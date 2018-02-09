//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UINavigationBar+TextStyle.h"
#import <Styles/Styles-Swift.h>
#import <objc/runtime.h>
#import "UIView+Styles.h"
#import "Swizzle.h"

@implementation UINavigationBar (TextStyle)

SYNTHESIZE_PROPERTY_OBJ(TextStyle, textStyle, TextStyle);

- (void)applyStyle {
    [super applyStyle];
    self.titleTextAttributes = [self.textStyle attributes];
}

@end
