//  source: https://stackoverflow.com/questions/32758811/catching-nsexception-in-swift

#import <Foundation/Foundation.h>

@interface ObjC : NSObject
+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error;
@end
