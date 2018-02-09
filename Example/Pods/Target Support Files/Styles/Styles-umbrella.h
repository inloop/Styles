#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "Swizzle.h"
#import "UIButton+Styles.h"
#import "UILabel+TextStyle.h"
#import "UINavigationBar+TextStyle.h"
#import "UITextField+Styles.h"
#import "UIView+Styles.h"

FOUNDATION_EXPORT double StylesVersionNumber;
FOUNDATION_EXPORT const unsigned char StylesVersionString[];

