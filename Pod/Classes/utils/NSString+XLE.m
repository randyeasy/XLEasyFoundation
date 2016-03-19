//
//  NSString+XLE.m
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import "NSString+XLE.h"
#import "NSString+XLERegex.h"

@implementation NSString (XLE)

+ (BOOL)XLE_compreString:(NSString *)firstStr withString:(NSString *)secondStr;
{
    if ((!firstStr && !secondStr) || [firstStr isEqualToString:secondStr]) {
        return YES;
    }
    return NO;
}

+ (BOOL)XLE_rangeOfString:(NSString *)findStr atString:(NSString *)sourceStr;
{
    if (findStr.length<=0 || sourceStr.length<=0) {
        return NO;
    }
    return ([findStr rangeOfString:sourceStr].location != NSNotFound);
}

- (NSURL *)XLE_fileUrl;
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self]) {
        return [NSURL fileURLWithPath:self];
    }
    return nil;
}

- (NSString *)XLE_repeatStringWithNum:(NSInteger)num;
{
    NSMutableString *mut = [[NSMutableString alloc] init];
    for (int i=0; i<num; i++) {
        [mut appendString:self];
    }
    return [mut copy];
}

+ (NSString *)XLE_fillZero:(int)value toEnoughBit:(NSInteger)num;
{
    NSString *string = [NSString stringWithFormat:@"%d",value];
    if (string.length < num) {
        string = [[@"0" XLE_repeatStringWithNum:num - string.length] stringByAppendingString:string];
    }
    else if(string.length > num){
        string = [string substringToIndex:num];
    }
    return string;
}

- (int16_t)XLE_int16Value;
{
    return (int16_t)[self intValue];
}

/**
 *  去掉非数字的字符
 *
 *  @return
 */
- (NSString *)XLE_removeNonNumberStr;
{
    NSMutableString *mutStr = [NSMutableString new];
    for (int i=0; i<self.length; i++) {
        NSString *oneStr = [self substringWithRange:NSMakeRange(i, 1)];
        if ([oneStr XLE_isOnlyNumber]) {
            [mutStr appendString:oneStr];
        }
    }
    return [mutStr copy];
}

/**
 *  去掉开头和结尾的空格 换行
 *
 *  @return 字符串
 */
- (NSString *)XLE_trim;
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)XLE_containsHTMLTag
{
    NSRange r = [self rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch];
    return r.location != NSNotFound;
}

- (NSString *)XLE_stringByStrippingHTML
{
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
