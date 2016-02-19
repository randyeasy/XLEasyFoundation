//
//  NSArray+HanZiLog.m
//  Pods
//
//  Created by Randy on 14/11/3.
//

#import "NSArray+HanZiLog.h"

@implementation NSArray (HanZiLog)

- (NSString *)xle_hanZiLogStrWithIndent:(NSInteger)level
{
    NSString *spaceStr = @"\t";
    NSMutableString *levelStr = [NSMutableString stringWithString:@""];
    for (NSInteger i=level; i>0; i--) {
        [levelStr appendString:spaceStr];
    }
    NSMutableString *str = [NSMutableString stringWithFormat:@"[%lu个\n", (unsigned long)self.count];
    level++;
    for (id obj in self) {
        NSString *enterLineStr = @",\n";
        if ([self lastObject] == obj) {
            enterLineStr = @"\n";
        }
        if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {

            [str appendFormat:@"%@%@%@%@",levelStr,spaceStr,[obj xle_hanZiLogStrWithIndent:level],enterLineStr];
        }
        else
            [str appendFormat:@"%@%@%@%@",levelStr,spaceStr, obj,enterLineStr];
    }
    
    [str appendFormat:@"%@]",levelStr];
    
    return str;
}

- (NSString *)xle_hanZiLogStr
{
    return [self xle_hanZiLogStrWithIndent:0];
}
@end
