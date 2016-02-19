//
//  NSDictionary+XLEDataValue.m
//  Pods
//
//  Created by Randy on 16/02/19.
//

#import "NSDictionary+XLEDataValue.h"
#import "NSDate+XLE.h"

@implementation NSDictionary (XLEDataValue)

- (int)xle_intForKey:(NSString *)key
{
    return [self xle_intForKey:key defaultValue:0];
}

- (NSInteger)xle_integerForKey:(NSString *)key
{
    return [self xle_integerForKey:key defaultValue:0];
}

- (long)xle_longForKey:(NSString *)key
{
    return [self xle_longForKey:key defaultValue:0];
}

- (long long)xle_longLongForKey:(NSString *)key
{
    return [self xle_longLongForKey:key defaultValue:0];
}

- (float)xle_floatForKey:(NSString *)key
{
    return [self xle_floatForKey:key defaultValue:0.0f];
}

- (double)xle_doubleForKey:(NSString *)key
{
    return [self xle_doubleForKey:key defaultValue:0.0f];
}

- (BOOL)xle_boolForKey:(NSString *)key
{
    return [self xle_boolForKey:key defaultValue:NO];
}

- (NSString *)xle_stringForKey:(NSString *)key
{
    return [self xle_stringForKey:key defaultValue:@""];
}

- (NSArray *)xle_arrayForKey:(NSString *)key;
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        return [value copy];
    }
    return nil;
}

- (NSDictionary *)xle_dictionaryForKey:(NSString *)key;
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return [value copy];
    }
    return nil;
}

- (NSDate *)xle_dateForKey:(NSString *)key;
{
    return [self xle_dateForKey:key defaultValue:nil];
}

- (NSURL *)xle_urlForKey:(NSString *)key;
{
    return [self xle_urlForKey:key defaultValue:nil];
}

- (NSDate *)xle_dateForKeyFromDateOrTime:(NSString *)key;
{
    return [self xle_dateForKeyFromDateOrTime:key defaultValue:nil];
}

- (NSURL *)xle_urlForKeyFromUrlOrString:(NSString *)key;
{
    return [self xle_urlForKeyFromUrlOrString:key defaultValue:nil];
}

#pragma mark -defaultValue

- (BOOL)xle_isNumberOrString:(id)value
{
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return YES;
    }
    return NO;
}

- (int)xle_intForKey:(NSString *)key defaultValue:(int)defaultValue
{
    id value = [self objectForKey:key];
    return [self xle_isNumberOrString:value] ? [value intValue] : defaultValue;
}

- (NSInteger)xle_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    id value = [self objectForKey:key];
    return [self xle_isNumberOrString:value] ? [value integerValue] : defaultValue;
}

- (long)xle_longForKey:(NSString *)key defaultValue:(long)defaultValue
{
    id value = [self objectForKey:key];
    return [self xle_isNumberOrString:value] ? [value longValue] : defaultValue;
}

- (long long)xle_longLongForKey:(NSString *)key defaultValue:(long long)defaultValue
{
    id value = [self objectForKey:key];
    return [self xle_isNumberOrString:value] ? [value longLongValue] : defaultValue;
}

- (float)xle_floatForKey:(NSString *)key defaultValue:(float)defaultValue
{
    id value = [self objectForKey:key];
    return [self xle_isNumberOrString:value] ? [value floatValue] : defaultValue;
}

- (double)xle_doubleForKey:(NSString *)key defaultValue:(double)defaultValue
{
    id value = [self objectForKey:key];
    return [self xle_isNumberOrString:value] ? [value doubleValue] : defaultValue;
}

- (BOOL)xle_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    id value = [self objectForKey:key];
    return [self xle_isNumberOrString:value] ? [value boolValue] : defaultValue;
}

- (NSString *)xle_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue
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

- (NSDate *)xle_dateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue;
{
    id value = [self objectForKey:key];
    return [value isKindOfClass:[NSDate class]]?value:defaultValue;
}

- (NSURL *)xle_urlForKey:(NSString *)key defaultValue:(NSURL *)defaultValue;
{
    id value = [self objectForKey:key];
    return [value isKindOfClass:[NSURL class]]?value:defaultValue;
}

- (NSDate *)xle_dateForKeyFromDateOrTime:(NSString *)key defaultValue:(NSDate *)defaultValue;
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDate class]]) {
        return value;
    }
    long long time = [self xle_longLongForKey:key defaultValue:-1];
    if (time >= 0) {
        NSDate *date = [NSDate xle_dateWithTimeIntervalInMilliSecondSince1970:time];
        if (date) {
            return date;
        }
    }
    return defaultValue;
}

- (NSURL *)xle_urlForKeyFromUrlOrString:(NSString *)key defaultValue:(NSURL *)defaultValue;
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
