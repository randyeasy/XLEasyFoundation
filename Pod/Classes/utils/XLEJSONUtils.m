//
//  XLEJsonUtils.m
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import "XLEJSONUtils.h"

@implementation XLEJSONUtils

+ (NSData *)xle_jsonToData:(id)json
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil)
        return jsonData;
    return nil;
}


+ (NSString *)xle_jsonToString:(id)json
{
    NSData *data = [XLEJSONUtils xle_jsonToData:json];
    if (data)
    {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (id)xle_stringToJson:(NSString *)string;
{
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) {

        return nil;
    }
    return result;
}

- (id)xle_dataToJson:(NSData *)data;
{
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) {
        
        return nil;
    }
    return result;
}

@end
