//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

@class TextStyle;

@interface UILabel (Styles)
@property (nonatomic, copy) TextStyle *textStyle UI_APPEARANCE_SELECTOR;
@end
