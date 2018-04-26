//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UINavigationBar+Styles.h"
#import <Styles/Styles-Swift.h>
#import <objc/runtime.h>
#import "UIView+Styles.h"
#import "Swizzle.h"

@implementation UINavigationBar (Styles)

SYNTHESIZE_PROPERTY_OBJ(TextStyle, titleTextStyle, TitleTextStyle);
SYNTHESIZE_PROPERTY_OBJ(TextStyle, largeTitleTextStyle, LargeTitleTextStyle);

- (void)applyStyle {
    [super applyStyle];
    self.titleTextAttributes = [self.titleTextStyle attributes];
    if (@available(iOS 11.0, *)) {
        self.largeTitleTextAttributes = [self.largeTitleTextStyle attributes];
    }
}

@end
