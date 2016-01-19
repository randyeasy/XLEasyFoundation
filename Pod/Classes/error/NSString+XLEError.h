//
//  NSString+XLEError.h
//  Pods
//
//  Created by Randy on 15/12/31.
//
//

#import <Foundation/Foundation.h>
#import "XLEError.h"
@interface NSString (XLEError)

/**
 *  通过字符串返回 BJPErrorInteger 值
 *
 *  @return
 */
- (XLEErrorInteger)xle_errorIntegerValue;

@end
