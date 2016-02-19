//
//  NSString+XLERegex.h
//  Pods
//
//  Created by Randy on 15/11/27.
//
//

#import <Foundation/Foundation.h>

@interface NSString (XLERegex)

/**
 *  检查字符串是否符合正则表达式
 *
 *  @param aStr 正则表达式
 *
 *  @return 符合：YES，不符合：NO
 */
- (BOOL)xle_evaluateWithRegex:(NSString *)aStr;

/**
 *  检查包含是否是重复的数字
 *
 *  @param count 重复几次 大于1
 *
 *  @return 重复：YES count小于2：NO
 */
- (BOOL)xle_isRepeatNum:(NSInteger)count;

/**
 *  是合法的身份证号 15或18位，最后一位可以是字母，其他都必须是数字
 *
 *  @return 合法：YES
 */
- (BOOL)xle_isLegalOwnerId;

/**
 *  检测是否是纯数字字符串 数字一位以上
 *
 *  @return 是：YES
 */
- (BOOL)xle_isOnlyNumber;

/**
 *  检测是否是合法的邮箱
 *
 *  @return 是：YES
 */
- (BOOL)xle_isLegalEmail;

/**
 *  检测是否是合法的手机号 1开头+10位数字
 *
 *  @return 是：YES
 */
- (BOOL)xle_isLegalMobile;

/**
 *  检测是否是合法的URL
 *
 *  @return 是：YES
 */
- (BOOL)xle_isLegalURL;

/**
 *  是否是纯汉字字符串
 *
 *  @return 是：YES
 */
- (BOOL)xle_isChinese;

/**
 *  检测是否包含 emoji
 *
 *  @return 包含：YES
 */
- (BOOL)xle_hasEmoji;

/**
 *  检测是否只包含字母 且一个字母以上
 *
 *  @return 是：YES
 */
- (BOOL)xle_isOnlyLetter;

@end
