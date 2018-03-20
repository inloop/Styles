//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#ifndef Swizzle_h
#define Swizzle_h

#import <Foundation/Foundation.h>

/// :nodoc:
FOUNDATION_EXPORT void swizzle_instance_method(Class class, SEL original, SEL swizzled);

/// :nodoc:
#define SYNTHESIZE_PROPERTY_OBJ(TYPE, PROPERTY_NAME, PROPERTY_NAME_UPPER) \
\
- (void)set##PROPERTY_NAME_UPPER:(TYPE *)PROPERTY_NAME { \
    objc_setAssociatedObject(self, @selector(PROPERTY_NAME), PROPERTY_NAME, OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
    [self applyStyle]; \
} \
\
- (TYPE *)PROPERTY_NAME { \
    return objc_getAssociatedObject(self, @selector(PROPERTY_NAME)); \
} \


#endif /* Swizzle.h */
