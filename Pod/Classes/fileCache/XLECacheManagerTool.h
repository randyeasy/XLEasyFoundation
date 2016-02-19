//
//  XLECacheManagerTool.h
//  pods
//
//  Created by Randy on 15/1/5.
//

#import <Foundation/Foundation.h>

/**
 *  本地文件缓存 Cache 和 临时目录
 */
@interface XLECacheManagerTool : NSObject

#pragma cache NSTemporaryDirectory
- (void)clearCacheWithSuccess:(void(^)(void))success;
- (void)clearCacheWithDir:(NSString *)dirName success:(void(^)(void))success;

#pragma mark - 文件大小
/**
 *  sync 同步
 *
 *  @return
 */
- (CGFloat)getCacheFileSize;
/**
 *
 * Async 异步
 *  @param finish
 */
- (void)getCacheFileSize:(void(^)(CGFloat size))finish;

@end
