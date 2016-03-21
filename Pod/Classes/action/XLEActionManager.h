//
//  XLEActionManager.h
//  XLEasyTemplates
//
//  Created by Randy on 16/3/21.
//  Copyright © 2016年 Randy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLEAction.h"
#import "XLEActionContext.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const XLE_ACTION_NO_SUPPORT_VIEW;
extern NSString *const XLE_ACTION_NEED_UPGRADE_VIEW;

@interface XLEActionManager : NSObject

+ (instancetype)sharedInstance;

- (void)regisgerActionModule:(XLEAction *)action;

- (void)unRegisterActionModule:(XLEAction *)action;

/**
 *  处理url action跳转
 *
 *  @param url      url app://xle.c/login
 *  @param payload  跳转参数
 *  @param context  当前上下文
 *  @param callback 回调
 */
- (void)handleOpenUrl:(NSString *)url
          withPayload:(NSDictionary *)payload
              context:(nullable XLEActionContext *)context
             callback:(nullable XLEActionHandlerCallback)callback;

@end

NS_ASSUME_NONNULL_END