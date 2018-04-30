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

#import "Styles.h"
#import "Swizzle.h"
#import "TextInputState.h"
#import "UIButton+Styles.h"
#import "UILabel+Styles.h"
#import "UINavigationBar+Styles.h"
#import "UITextField+Styles.h"
#import "UITextView+Styles.h"
#import "UIView+Styles.h"
#import "UISwitch+Styles.h"

FOUNDATION_EXPORT double StylesVersionNumber;
FOUNDATION_EXPORT const unsigned char StylesVersionString[];

