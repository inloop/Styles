//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import <UIKit/UIKit.h>

@class TextStyle;

@interface UINavigationBar (TextStyle)
@property (nonatomic, copy) TextStyle *titleTextStyle UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) TextStyle *largeTitleTextStyle UI_APPEARANCE_SELECTOR API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);
@end
