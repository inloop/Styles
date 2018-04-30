//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "UISwitch+Styles.h"
#import "UIView+Styles.h"
#import <Styles/Styles-Swift.h>
#import <objc/runtime.h>
#import "Swizzle.h"

@implementation UISwitch (Styles)

SYNTHESIZE_PROPERTY_OBJ(SwitchStyle, switchStyle, SwitchStyle)

- (void)applyStyle {
    [super applyStyle];
    [self.switchStyle applyTo:self];
}

@end
