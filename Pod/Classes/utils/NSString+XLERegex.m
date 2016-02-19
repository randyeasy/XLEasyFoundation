//
//  NSString+XLERegex.m
//  Pods
//
//  Created by Randy on 15/11/27.
//
//

#import "NSString+XLERegex.h"

@implementation NSString (XLERegex)

/**
 *  检查字符串是否符合正则表达式
 *
 *  @param aStr 正则表达式
 *
 *  @return 符合：YES，不符合：NO
 */
- (BOOL)xle_evaluateWithRegex:(NSString *)aStr
{
    NSString *regex = aStr;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


/**
 *  是合法的身份证号 15或18位，最后一位可以是字母，其他都必须是数字
 *
 *  @return 合法：YES
 */
- (BOOL)xle_isLegalOwnerId;
{
    return [self xle_evaluateWithRegex:@"^[0-9]{14,17}[A-Za-z0-9]$"];
}

/**
 *  检查包含是否是重复的数字
 *
 *  @param count 重复几次 大于1
 *
 *  @return 重复：YES count小于2：NO
 */
- (BOOL)xle_isRepeatNum:(NSInteger)count;
{
    if (count<2) {
        return NO;
    }
    return [self xle_evaluateWithRegex:[NSString stringWithFormat:@"[0-9]*?(\\d)\\1{%ld}[0-9]*?",(long)(count-1)]];
}

/**
 *  检测是否是纯数字字符串
 *
 *  @return 是：YES
 */
- (BOOL)xle_isOnlyNumber
{
    return [self xle_evaluateWithRegex:@"^[0-9]+$"];
}

/**
 *  检测是否是合法的邮箱 TODO 测试
 *
 *  @return 是：YES
 */
- (BOOL)xle_isLegalEmail;
{
    return [self xle_evaluateWithRegex:@"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"];
}

/**
 *  检测是否是合法的手机号
 *
 *  @return 是：YES
 */
- (BOOL)xle_isLegalMobile;
{
    return [self xle_evaluateWithRegex:@"^1[0-9]{10}$"];
}

/**
 *  检测是否是合法的URL
 *
 *  @return 是：YES
 */
- (BOOL)xle_isLegalURL;
{
    NSString *match=@"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
    return [self xle_evaluateWithRegex:match];
}

/**
 *  是否是纯汉字字符串
 *
 *  @return 是：YES
 */
- (BOOL)xle_isChinese;
{
    return [self xle_evaluateWithRegex:@"(^[\u4e00-\u9fa5]+$)"];
}

/**
 *  检测是否包含 emoji
 *
 *  @return 包含：YES
 */
- (BOOL)xle_hasEmoji;
{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    return returnValue;
}

/**
 *  检测是否只包含字母
 *
 *  @return 是：YES
 */
- (BOOL)xle_isOnlyLetter;
{
    return [self xle_evaluateWithRegex:@"^[A-Za-z]+$"];
}

@end
