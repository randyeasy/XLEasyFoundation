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
+ (NSData *)XLE_jsonToData:(id)json;
+ (NSString *)XLE_jsonToString:(id)json;

//将Json string or data转化为NSArray or NSDictionary
- (id)XLE_stringToJson:(NSString *)string;
- (id)XLE_dataToJson:(NSData *)data;
@end
