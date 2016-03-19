//
//  NSArray+XLEHanZiLog.m
//  Pods
//
//  Created by Randy on 14/11/3.
//

#import "NSArray+XLEHanZiLog.h"

@implementation NSArray (XLEHanZiLog)

- (NSString *)XLE_hanZiLogStrWithIndent:(NSInteger)level
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

            [str appendFormat:@"%@%@%@%@",levelStr,spaceStr,[obj XLE_hanZiLogStrWithIndent:level],enterLineStr];
        }
        else
            [str appendFormat:@"%@%@%@%@",levelStr,spaceStr, obj,enterLineStr];
    }
    
    [str appendFormat:@"%@]",levelStr];
    
    return str;
}

- (NSString *)XLE_hanZiLogStr
{
    return [self XLE_hanZiLogStrWithIndent:0];
}
@end
