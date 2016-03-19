//
//  XLEAction.m
//  Pods
//
//  Created by Randy on 16/3/18.
//
//

#import "XLEAction.h"
#import "XLEActionModel.h"

@interface XLEAction ()
@property (copy, nonatomic) NSString *scheme;
@property (copy, nonatomic) NSString *host;
@property (copy, nullable, nonatomic) NSString *subPath;

@property (strong, nonatomic) NSMutableDictionary *listeners;
@end

@implementation XLEAction

- (instancetype)initWithScheme:(NSString *)scheme
                          host:(NSString *)host
                       subPath:(nullable NSString *)subPath;
{
    self = [super init];
    if (self) {
        _scheme = scheme;
        _host = host;
        _subPath = subPath;
    }
    return self;
}

- (void)addListenerWithName:(NSString *)name
                     handle:(XLEActionHandler)handler;
{
    if (name.length>0 && handler) {
        NSAssert1(![self.listeners objectForKey:name], @"%@ 添加了多个监听，请检查", name);
        [self.listeners setObject:handler forKey:name];
    }
}

- (void)removeListenerWithName:(NSString *)name;
{
    [self.listeners removeObjectForKey:name];
}

- (BOOL)handleOpenUrl:(NSString *)url
          withPayload:(NSDictionary *)payload
              context:(nullable XLEActionContext *)context
             callback:(nullable XLEActionHandlerCallback)callback;
{
    XLEActionModel *actionModel = [[XLEActionModel alloc] initWithUrl:[NSURL URLWithString:url]];
    if ([self.scheme isEqualToString:actionModel.scheme] && [self.host isEqualToString:actionModel.host]) {
        if (!self.subPath || [self.subPath isEqualToString:actionModel.subPath]) {
            XLEActionHandler handler = [self.listeners objectForKey:actionModel.name];
            if (handler) {
                return handler(context,payload,callback);
            }
        }
    }
    return NO;
}

#pragma mark - set get
- (NSMutableDictionary *)listeners{
    if (_listeners == nil) {
        _listeners = [NSMutableDictionary new];
    }
    return _listeners;
}

@end
