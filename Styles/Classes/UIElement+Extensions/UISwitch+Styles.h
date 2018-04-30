//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

@class SwitchStyle;

@interface UISwitch (Styles)
@property (nonatomic, copy) SwitchStyle *switchStyle UI_APPEARANCE_SELECTOR;
@end
