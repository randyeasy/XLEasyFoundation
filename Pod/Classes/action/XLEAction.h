//
//  XLEAction.h
//  Pods
//
//  Created by Randy on 16/3/18.
//
//

#import <Foundation/Foundation.h>
#import "XLEActionContext.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ XLEActionHandlerCallback)(NSDictionary *callbackPayload);
typedef BOOL (^ XLEActionHandler)(XLEActionContext *_Nullable context,NSDictionary *payload, XLEActionHandlerCallback _Nullable callback);


@interface XLEAction : NSObject
@property (copy, readonly, nonatomic) NSString *scheme;
@property (copy, readonly, nonatomic) NSString *host;
@property (copy, readonly, nullable, nonatomic) NSString *subPath;

- (instancetype)initWithScheme:(NSString *)scheme
                          host:(NSString *)host
                       subPath:(nullable NSString *)subPath;

/**
 *  一个name只能有一个监听，当添加了多个监听时，最后的覆盖前面添加的
 *
 *  @param name    action 名称
 *  @param handler 监听回调
 */
- (void)addListenerWithName:(NSString *)name
                     handle:(XLEActionHandler)handler;
- (void)removeListenerWithName:(NSString *)name;

- (BOOL)handleOpenUrl:(NSString *)url
          withPayload:(NSDictionary *)payload
                 context:(nullable XLEActionContext *)context
             callback:(nullable XLEActionHandlerCallback)callback;

@end

NS_ASSUME_NONNULL_END
