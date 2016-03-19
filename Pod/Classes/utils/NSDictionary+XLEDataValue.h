//
//  NSDictionary+XLEDataValue.h
//  Pods
//
//  Created by Randy on 16/02/19.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XLEDataValue)

- (int)XLE_intForKey:(NSString *)key;
- (NSInteger)XLE_integerForKey:(NSString *)key;
- (long)XLE_longForKey:(NSString *)key;
- (long long)XLE_longLongForKey:(NSString *)key;
- (float)XLE_floatForKey:(NSString *)key;
- (double)XLE_doubleForKey:(NSString *)key;
- (BOOL)XLE_boolForKey:(NSString *)key;
- (NSString *)XLE_stringForKey:(NSString *)key;
- (NSArray *)XLE_arrayForKey:(NSString *)key;
- (NSDictionary *)XLE_dictionaryForKey:(NSString *)key;
- (NSDate *)XLE_dateForKey:(NSString *)key;
- (NSURL *)XLE_urlForKey:(NSString *)key;
- (NSDate *)XLE_dateForKeyFromDateOrTime:(NSString *)key;
- (NSURL *)XLE_urlForKeyFromUrlOrString:(NSString *)key;

- (int)XLE_intForKey:(NSString *)key defaultValue:(int)defaultValue;
- (NSInteger)XLE_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (long)XLE_longForKey:(NSString *)key defaultValue:(long)defaultValue;
- (long long)XLE_longLongForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (float)XLE_floatForKey:(NSString *)key defaultValue:(float)defaultValue;
- (double)XLE_doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
- (BOOL)XLE_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (NSString *)XLE_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSDate *)XLE_dateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue;
- (NSURL *)XLE_urlForKey:(NSString *)key defaultValue:(NSURL *)defaultValue;
- (NSDate *)XLE_dateForKeyFromDateOrTime:(NSString *)key defaultValue:(NSDate *)defaultValue;
- (NSURL *)XLE_urlForKeyFromUrlOrString:(NSString *)key defaultValue:(NSURL *)defaultValue;
@end
