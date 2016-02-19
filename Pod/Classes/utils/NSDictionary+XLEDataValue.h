//
//  NSDictionary+XLEDataValue.h
//  Pods
//
//  Created by Randy on 16/02/19.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XLEDataValue)

- (int)xle_intForKey:(NSString *)key;
- (NSInteger)xle_integerForKey:(NSString *)key;
- (long)xle_longForKey:(NSString *)key;
- (long long)xle_longLongForKey:(NSString *)key;
- (float)xle_floatForKey:(NSString *)key;
- (double)xle_doubleForKey:(NSString *)key;
- (BOOL)xle_boolForKey:(NSString *)key;
- (NSString *)xle_stringForKey:(NSString *)key;
- (NSArray *)xle_arrayForKey:(NSString *)key;
- (NSDictionary *)xle_dictionaryForKey:(NSString *)key;
- (NSDate *)xle_dateForKey:(NSString *)key;
- (NSURL *)xle_urlForKey:(NSString *)key;
- (NSDate *)xle_dateForKeyFromDateOrTime:(NSString *)key;
- (NSURL *)xle_urlForKeyFromUrlOrString:(NSString *)key;

- (int)xle_intForKey:(NSString *)key defaultValue:(int)defaultValue;
- (NSInteger)xle_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (long)xle_longForKey:(NSString *)key defaultValue:(long)defaultValue;
- (long long)xle_longLongForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (float)xle_floatForKey:(NSString *)key defaultValue:(float)defaultValue;
- (double)xle_doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
- (BOOL)xle_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (NSString *)xle_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSDate *)xle_dateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue;
- (NSURL *)xle_urlForKey:(NSString *)key defaultValue:(NSURL *)defaultValue;
- (NSDate *)xle_dateForKeyFromDateOrTime:(NSString *)key defaultValue:(NSDate *)defaultValue;
- (NSURL *)xle_urlForKeyFromUrlOrString:(NSString *)key defaultValue:(NSURL *)defaultValue;
@end
