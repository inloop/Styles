//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

#import "Swizzle.h"
#import <objc/runtime.h>

void swizzle_method(Class class, SEL originalSelector, SEL swizzledSelector, Method originalMethod, Method swizzledMethod);

void swizzle_instance_method(Class class, SEL original, SEL swizzled)
{
    Method originalMethod = class_getInstanceMethod(class, original);
    Method swizzledMethod = class_getInstanceMethod(class, swizzled);
    swizzle_method(class, original, swizzled, originalMethod, swizzledMethod);
}

void swizzle_method(Class class, SEL originalSelector, SEL swizzledSelector, Method originalMethod, Method swizzledMethod)
{
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));

    if (didAddMethod)
    {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
