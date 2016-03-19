//
//  NSDictionary+XLEDataValue.m
//  Pods
//
//  Created by Randy on 16/02/19.
//

#import "NSDictionary+XLEDataValue.h"
#import "NSDate+XLE.h"

@implementation NSDictionary (XLEDataValue)

- (int)XLE_intForKey:(NSString *)key
{
    return [self XLE_intForKey:key defaultValue:0];
}

- (NSInteger)XLE_integerForKey:(NSString *)key
{
    return [self XLE_integerForKey:key defaultValue:0];
}

- (long)XLE_longForKey:(NSString *)key
{
    return [self XLE_longForKey:key defaultValue:0];
}

- (long long)XLE_longLongForKey:(NSString *)key
{
    return [self XLE_longLongForKey:key defaultValue:0];
}

- (float)XLE_floatForKey:(NSString *)key
{
    return [self XLE_floatForKey:key defaultValue:0.0f];
}

- (double)XLE_doubleForKey:(NSString *)key
{
    return [self XLE_doubleForKey:key defaultValue:0.0f];
}

- (BOOL)XLE_boolForKey:(NSString *)key
{
    return [self XLE_boolForKey:key defaultValue:NO];
}

- (NSString *)XLE_stringForKey:(NSString *)key
{
    return [self XLE_stringForKey:key defaultValue:@""];
}

- (NSArray *)XLE_arrayForKey:(NSString *)key;
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        return [value copy];
    }
    return nil;
}

- (NSDictionary *)XLE_dictionaryForKey:(NSString *)key;
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return [value copy];
    }
    return nil;
}

- (NSDate *)XLE_dateForKey:(NSString *)key;
{
    return [self XLE_dateForKey:key defaultValue:nil];
}

- (NSURL *)XLE_urlForKey:(NSString *)key;
{
    return [self XLE_urlForKey:key defaultValue:nil];
}

- (NSDate *)XLE_dateForKeyFromDateOrTime:(NSString *)key;
{
    return [self XLE_dateForKeyFromDateOrTime:key defaultValue:nil];
}

- (NSURL *)XLE_urlForKeyFromUrlOrString:(NSString *)key;
{
    return [self XLE_urlForKeyFromUrlOrString:key defaultValue:nil];
}

#pragma mark -defaultValue

- (BOOL)XLE_isNumberOrString:(id)value
{
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return YES;
    }
    return NO;
}

- (int)XLE_intForKey:(NSString *)key defaultValue:(int)defaultValue
{
    id value = [self objectForKey:key];
    return [self XLE_isNumberOrString:value] ? [value intValue] : defaultValue;
}

- (NSInteger)XLE_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    id value = [self objectForKey:key];
    return [self XLE_isNumberOrString:value] ? [value integerValue] : defaultValue;
}

- (long)XLE_longForKey:(NSString *)key defaultValue:(long)defaultValue
{
    id value = [self objectForKey:key];
    return [self XLE_isNumberOrString:value] ? [value longValue] : defaultValue;
}

- (long long)XLE_longLongForKey:(NSString *)key defaultValue:(long long)defaultValue
{
    id value = [self objectForKey:key];
    return [self XLE_isNumberOrString:value] ? [value longLongValue] : defaultValue;
}

- (float)XLE_floatForKey:(NSString *)key defaultValue:(float)defaultValue
{
    id value = [self objectForKey:key];
    return [self XLE_isNumberOrString:value] ? [value floatValue] : defaultValue;
}

- (double)XLE_doubleForKey:(NSString *)key defaultValue:(double)defaultValue
{
    id value = [self objectForKey:key];
    return [self XLE_isNumberOrString:value] ? [value doubleValue] : defaultValue;
}

- (BOOL)XLE_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    id value = [self objectForKey:key];
    return [self XLE_isNumberOrString:value] ? [value boolValue] : defaultValue;
}

- (NSString *)XLE_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    id<NSObject> value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] && ((NSString *)value).length > 0) {
        return [((NSString *)value) copy];
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",value];
    }
    return defaultValue;
}

- (NSDate *)XLE_dateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue;
{
    id value = [self objectForKey:key];
    return [value isKindOfClass:[NSDate class]]?value:defaultValue;
}

- (NSURL *)XLE_urlForKey:(NSString *)key defaultValue:(NSURL *)defaultValue;
{
    id value = [self objectForKey:key];
    return [value isKindOfClass:[NSURL class]]?value:defaultValue;
}

- (NSDate *)XLE_dateForKeyFromDateOrTime:(NSString *)key defaultValue:(NSDate *)defaultValue;
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDate class]]) {
        return value;
    }
    long long time = [self XLE_longLongForKey:key defaultValue:-1];
    if (time >= 0) {
        NSDate *date = [NSDate XLE_dateWithTimeIntervalInMilliSecondSince1970:time];
        if (date) {
            return date;
        }
    }
    return defaultValue;
}

- (NSURL *)XLE_urlForKeyFromUrlOrString:(NSString *)key defaultValue:(NSURL *)defaultValue;
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSURL class]]) {
        return value;
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        NSURL *url = [NSURL URLWithString:value];
        if (url) {
            return url;
        }
    }
    return defaultValue;
}

@end
