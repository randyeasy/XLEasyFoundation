//
//  XLEJsonUtils.m
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import "XLEJSONUtils.h"

@implementation XLEJSONUtils

+ (NSData *)XLE_jsonToData:(id)json
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil)
        return jsonData;
    return nil;
}


+ (NSString *)XLE_jsonToString:(id)json
{
    NSData *data = [XLEJSONUtils XLE_jsonToData:json];
    if (data)
    {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (id)XLE_stringToJson:(NSString *)string;
{
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) {

        return nil;
    }
    return result;
}

- (id)XLE_dataToJson:(NSData *)data;
{
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) {
        
        return nil;
    }
    return result;
}

@end
