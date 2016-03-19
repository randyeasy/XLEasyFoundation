//
//  NSDictionary+XLEHanZiLog.h
//  Pods
//
//  Created by Randy on 15/1/26.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XLEHanZiLog)
- (NSString *)XLE_hanZiLogStr;
- (NSString *)XLE_hanZiLogStrWithIndent:(NSInteger)level;
@end
