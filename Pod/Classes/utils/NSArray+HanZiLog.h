//
//  NSArray+HanZiLog.h
//  Pods
//
//  Created by Randy on 14/15/3.
//

#import <Foundation/Foundation.h>

@interface NSArray (HanZiLog)
- (NSString *)xle_hanZiLogStr;
- (NSString *)xle_hanZiLogStrWithIndent:(NSInteger)level;
@end
