//
//  XLEActionManager.m
//  XLEasyTemplates
//
//  Created by Randy on 16/3/21.
//  Copyright © 2016年 Randy. All rights reserved.
//

#import "XLEActionManager.h"
#import "XLEUpgrageManager.h"

NSString *const XLE_ACTION_NO_SUPPORT_VIEW   = @"nosupport";
NSString *const XLE_ACTION_NEED_UPGRADE_VIEW = @"needUpgrade";

@interface XLEActionManager ()
@property (strong, nonatomic) NSMutableArray<XLEAction *> *actionModules;
@property (copy, nonatomic) NSString *noSupportViewAction;
@property (copy, nonatomic) NSString *upgradeViewAction;

@end

@implementation XLEActionManager

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)regisgerActionModule:(XLEAction *)action;
{
    [self.actionModules addObject:action];
}

- (void)unRegisterActionModule:(XLEAction *)action
{
    [self.actionModules removeObject:action];
}

- (void)handleOpenUrl:(NSString *)url
          withPayload:(NSDictionary *)payload
              context:(nullable XLEActionContext *)context
             callback:(nullable XLEActionHandlerCallback)callback;
{
    BOOL canHandle = NO;
    for (XLEAction *action in self.actionModules) {
        if ([action handleOpenUrl:url
                      withPayload:payload
                          context:context
                         callback:callback]) {
            canHandle = YES;
            break;
        }
    }
    
    //如果没有处理，则返回需要升级的页面，或者404页面
    if (!canHandle &&
        ![XLE_ACTION_NO_SUPPORT_VIEW isEqualToString:url] &&
        ![XLE_ACTION_NEED_UPGRADE_VIEW isEqualToString:url]) {
        if ([XLEUpgrageManager sharedInstance].status == XLE_UPDATE_HAS) {
            [self handleOpenUrl:XLE_ACTION_NEED_UPGRADE_VIEW withPayload:payload context:context callback:callback];
        }
        else{
            [self handleOpenUrl:XLE_ACTION_NO_SUPPORT_VIEW withPayload:payload context:context callback:callback];
        }
    }
}

#pragma mark - set get
- (NSMutableArray<XLEAction *> *)actionModules{
    if (_actionModules == nil) {
        _actionModules = [NSMutableArray new];
    }
    return _actionModules;
}

@end
