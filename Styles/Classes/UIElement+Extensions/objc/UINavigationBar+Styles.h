//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

@class TextStyle;

/**
 UINavigationBar+Styles allows to modify title text style
 */
@interface UINavigationBar (TextStyle)
/// TextStyle to be applied to title
@property (nonatomic, copy) TextStyle *titleTextStyle UI_APPEARANCE_SELECTOR;
/// From #iOS11 you can set large title and its TextStyle
@property (nonatomic, copy) TextStyle *largeTitleTextStyle UI_APPEARANCE_SELECTOR API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);
@end
