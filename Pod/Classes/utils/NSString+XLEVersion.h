//
//  NSString+XLEVersion.h
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import <Foundation/Foundation.h>

@interface NSString (XLEVersion)

-(BOOL)XLE_isOlderThanVersion:(NSString *)version;
-(BOOL)XLE_isNewerThanVersion:(NSString *)version;
-(BOOL)XLE_isEqualToVersion:(NSString *)version;
-(BOOL)XLE_isEqualOrOlderThanVersion:(NSString *)version;
-(BOOL)XLE_isEqualOrNewerThanVersion:(NSString *)version;

@end
