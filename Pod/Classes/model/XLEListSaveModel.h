//
//  BJPListSaveModel.h
//  Pods
//
//  Created by Randy on 16/3/14.
//
//

#import "XLEModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 自动保存当前的列表数据到本地
 */

@interface XLEListSaveModel : XLEModel

/**
 *  初始化方法
 *
 *  @param cachePath 缓存的路径 请保证子path的目录都创建成功，里面不会自动创建
 *
 *  @return 
 */
- (instancetype)initWithCachePath:(NSString *)cachePath;
+ (instancetype)listSaveWithCachePath:(NSString *)cachePath;

- (void)removeAllObjects;
- (void)removeObjects:(NSArray<id<NSObject>> *)objects;
- (void)addObjects:(NSArray<id<NSObject>> *)objects;
- (void)removeObject:(id<NSObject>)object;
- (void)addObject:(id<NSObject>)object;
- (id)objectAtIndex:(NSInteger)index;
- (void)moveObjectToLastWithObject:(id<NSObject>)object;

- (NSUInteger)count;

@end

NS_ASSUME_NONNULL_END