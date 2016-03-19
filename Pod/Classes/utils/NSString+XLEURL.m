//
//  NSString+XLEURL.m
//  Pods
//
//  Created by Randy on 16/3/16.
//
//

#import "NSString+XLEURL.h"

@implementation NSString (XLEURL)
- (NSString *)XLE_stringByAppendUrlParam:(NSString *)value
                                  forKey:(NSString *)key;
{
    NSString *url = self;
    
    if (!value || !key) {
        return self;
    }
    if ([url rangeOfString:@"?"].location == NSNotFound){
        url = [url stringByAppendingString:@"?"];
        url = [url stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
    }
    else
    {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,value]];
    }
    
    return url;
}

- (NSString *)XLE_stringByAppendUrlParams:(NSDictionary *)params;
{
    NSString *url = self;
    for (NSString *oneKey in params) {
        [self XLE_stringByAppendUrlParam:params[oneKey] forKey:oneKey];
    }
    return url;
}

- (NSArray *)XLE_pathComponents;
{
    NSArray *paths = [self pathComponents];
    NSMutableArray *mutPaths = [paths mutableCopy];
    for (NSString *onePath in paths) {
        if ([onePath isEqualToString:@"/"]) {
            [mutPaths removeObject:onePath];
        }
    }
    return [mutPaths copy];
}

@end
