//
//  NSString+XLEURL.h
//  Pods
//
//  Created by Randy on 16/3/16.
//
//

#import <Foundation/Foundation.h>

@interface NSString (XLEURL)
- (NSString *)XLE_stringByAppendUrlParam:(NSString *)value
                                  forKey:(NSString *)key;
- (NSString *)XLE_stringByAppendUrlParams:(NSDictionary *)params;
- (NSArray *)XLE_pathComponents;

@end
