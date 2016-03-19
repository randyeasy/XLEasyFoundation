//
//  NSArray+XLEHanZiLog.h
//  Pods
//
//  Created by Randy on 14/15/3.
//

#import <Foundation/Foundation.h>

@interface NSArray (XLEHanZiLog)
- (NSString *)XLE_hanZiLogStr;
- (NSString *)XLE_hanZiLogStrWithIndent:(NSInteger)level;
@end
