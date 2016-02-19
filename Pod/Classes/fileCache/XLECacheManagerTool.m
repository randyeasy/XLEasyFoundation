//
//  XLECacheManagerTool.m
//  Pods
//
//  Created by Randy on 15/1/5.
//

#import "XLECacheManagerTool.h"
#import "XLEFileManagerTool.h"

@implementation XLECacheManagerTool

#pragma mark - all
//TODO 测试此接口
- (void)clearCacheWithSuccess:(void(^)(void))success
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [self clearCacheWithDir:[XLEFileManagerTool cachesDir] success:nil];
        [self clearCacheWithDir:[XLEFileManagerTool tmpDir] success:nil];

       dispatch_async(dispatch_get_main_queue(), ^{
           if (success) {
               success();
           }
       });
    });
}

//TODO测试
- (void)clearCacheWithDir:(NSString *)dirName success:(void(^)(void))success;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [XLEFileManagerTool deleteFilesWithDirPath:dirName];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success();
            }
        });
    });
}

- (CGFloat)getCacheFileSize
{
    CGFloat fileSize = 0;
    
    fileSize += [XLEFileManagerTool folderSizeAtPath:[XLEFileManagerTool cachesDir]];
    fileSize += [XLEFileManagerTool folderSizeAtPath:[XLEFileManagerTool tmpDir]];

    return fileSize;
}

- (void)getCacheFileSize:(void (^)(CGFloat))finish{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        CGFloat fileSize = 0;
        
        fileSize += [XLEFileManagerTool folderSizeAtPath:[XLEFileManagerTool cachesDir]];
        fileSize += [XLEFileManagerTool folderSizeAtPath:[XLEFileManagerTool tmpDir]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            if (finish) {
                finish(fileSize);
            }
        });
    });
}

@end
