//
//  NSString+XLE.h
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import <Foundation/Foundation.h>

@interface NSString (XLE)

+ (BOOL)xle_compreString:(NSString *)firstStr withString:(NSString *)secondStr;

+ (BOOL)xle_rangeOfString:(NSString *)findStr atString:(NSString *)sourceStr;

/**
 *  判断file是否存在，不存在则返回nil
 *
 *  @return file存在返回对应的URL，不存在nil
 */
- (NSURL *)xle_fileUrl;

/**
 *  把一个数字生成固定位数的字符串，不够位数的左边补0
 *
 *  @param value 数字
 *  @param num   固定多少位数
 *
 *  @return 满足条件的字符串
 */
+ (NSString *)xle_fillZero:(int)value toEnoughBit:(NSInteger)num;

/**
 *  把一个字符串重复拼接 例如 @“0” 重复拼接三次，变成 @“000”
 *
 *  @param num 重复次数
 *
 *  @return 满足条件的字符串
 */
- (NSString *)xle_repeatStringWithNum:(NSInteger)num;

- (int16_t)xle_int16Value;

/**
 *  去掉非数字的字符
 *
 *  @return
 */
- (NSString *)xle_removeNonNumberStr;

/**
 *  去掉开头和结尾的空格 换行
 *
 *  @return 字符串
 */
- (NSString *)xle_trim;

- (BOOL)xle_containsHTMLTag;

- (NSString *)xle_stringByStrippingHTML;

@end
