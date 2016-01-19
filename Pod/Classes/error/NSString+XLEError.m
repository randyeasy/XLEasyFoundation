//
//  NSString+XLEError.m
//  Pods
//
//  Created by Randy on 15/12/31.
//
//

#import "NSString+XLEError.h"

@implementation NSString (XLEError)

/**
 *  通过字符串返回 BJPErrorInteger 值
 *
 *  @return
 */
- (XLEErrorInteger)xle_errorIntegerValue;
{
    
#if _OS_IS_64
    return [self integerValue];
#else
    return [self longLongValue];
#endif
}

@end
