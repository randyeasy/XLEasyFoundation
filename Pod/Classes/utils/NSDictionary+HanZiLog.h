//
//  NSDictionary+HanZiLog.h
//  Pods
//
//  Created by Randy on 15/1/26.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HanZiLog)
- (NSString *)xle_hanZiLogStr;
- (NSString *)xle_hanZiLogStrWithIndent:(NSInteger)level;
@end
