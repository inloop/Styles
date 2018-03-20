//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

@class TextStyle;

/**
 UILabel+Styles allows to set the text style
 */
@interface UILabel (Styles)

/// TextStyle allows you to modify the visual appearance of the text
@property (nonatomic, copy) TextStyle *textStyle UI_APPEARANCE_SELECTOR;
@end
