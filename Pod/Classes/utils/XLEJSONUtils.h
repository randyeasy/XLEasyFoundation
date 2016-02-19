//
//  XLEJsonUtils.h
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import <Foundation/Foundation.h>

@interface XLEJSONUtils : NSObject

/**
 将 dictionary 或者 array 转位 Data or string
 */
+ (NSData *)xle_jsonToData:(id)json;
+ (NSString *)xle_jsonToString:(id)json;

//将Json string or data转化为NSArray or NSDictionary
- (id)xle_stringToJson:(NSString *)string;
- (id)xle_dataToJson:(NSData *)data;
@end
