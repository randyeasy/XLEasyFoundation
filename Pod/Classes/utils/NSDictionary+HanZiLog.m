//
//  NSDictionary+HanZiLog.m
//  Pods
//
//  Created by Randy on 15/1/26.
//

#import "NSDictionary+HanZiLog.h"

@implementation NSDictionary (HanZiLog)
- (NSString *)xle_hanZiLogStrWithIndent:(NSInteger)level
{
    NSString *spaceStr = @"\t";
    NSMutableString *levelStr = [NSMutableString stringWithString:@""];
    for (NSInteger i=level; i>0; i--) {
        [levelStr appendString:spaceStr];
    }
    NSMutableString *str = [NSMutableString stringWithString:@"{\n"];
    level++;
    NSArray *allKeys = [self allKeys];
    for (id obj in allKeys) {
        id objValue = [self objectForKey:obj];
        NSString *enterLineStr = @",\n";
        if ([allKeys lastObject] == obj) {
            enterLineStr = @"\n";
        }
        if ([objValue isKindOfClass:[NSArray class]] || [objValue isKindOfClass:[NSDictionary class]]) {
            [str appendFormat:@"%@%@\"%@\":%@%@",levelStr,spaceStr,obj,[objValue xle_hanZiLogStrWithIndent:level],enterLineStr];
        }
        else
        {
            if ([objValue isKindOfClass:[NSString class]]) {
                [str appendFormat:@"%@%@\"%@\":\"%@\"%@",levelStr,spaceStr, obj,[self objectForKey:obj],enterLineStr];
            }
            else
                [str appendFormat:@"%@%@\"%@\":%@%@",levelStr,spaceStr, obj,[self objectForKey:obj],enterLineStr];
        }
    }
    
    [str appendFormat:@"%@}",levelStr];
    
    return str;
}

- (NSString *)xle_hanZiLogStr
{
    return [self xle_hanZiLogStrWithIndent:0];
}

@end
