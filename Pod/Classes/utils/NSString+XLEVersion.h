//
//  NSString+XLEVersion.h
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import <Foundation/Foundation.h>

@interface NSString (XLEVersion)

-(BOOL)xle_isOlderThanVersion:(NSString *)version;
-(BOOL)xle_isNewerThanVersion:(NSString *)version;
-(BOOL)xle_isEqualToVersion:(NSString *)version;
-(BOOL)xle_isEqualOrOlderThanVersion:(NSString *)version;
-(BOOL)xle_isEqualOrNewerThanVersion:(NSString *)version;

@end
