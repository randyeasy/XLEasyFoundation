//
//  BJPDictionarySaveModel.h
//  Pods
//
//  Created by Randy on 16/3/14.
//
//

#import "XLEModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 自动保存当前的字典数据到本地
 */

@interface XLEDictionarySaveModel : XLEModel

/**
 *  保证path的子路径目录都创建成果
 *
 *  @param cachePath 保存路径
 *
 *  @return 
 */
+ (instancetype)dictionarySaveWithCachePath:(NSString *)cachePath;

- (instancetype)initWithCachePath:(NSString *)cachePath;

/**
 *  增加计数功能
 *
 *  @param object
 *  @param key
 */
- (void)setObject:(id<NSObject>)object forKey:(nonnull id<NSCopying>)key;

- (void)removeObjectForKey:(nonnull id<NSCopying>)key;

- (void)addEntriesFromDictionary:(NSDictionary *)dictionary;

- (void)removeObjectsForKeys:(NSArray *)list;

- (void)removeAllObjects;

- (nullable id)objectForKey:(nonnull id<NSCopying>)key;

- (NSUInteger)count;
@end

NS_ASSUME_NONNULL_END