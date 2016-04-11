//
//  XLEError.h
//  Pods
//
//  Created by Randy on 15/11/27.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int16_t, XLEErrorType) {
    XLE_ERROR_UNKNOWN = -1,
    XLE_ERROR_SUC = 0, //json解析失败
    XLE_ERROR_JSON_PARSE_FAIL = 1, //json解析失败
    
    //网络错误
};

typedef NS_ENUM(int16_t, XLEErrorEnvironmentType) {
    XLE_ENVIRONMENT_UNKOWN = 0, //未知
    XLE_ENVIRONMENT_IPHONE = 1, //iPhone端
    XLE_ENVIRONMENT_IPAD = 2, //iPad端
    XLE_ENVIRONMENT_APPLETV = 3, //appleTV
    XLE_ENVIRONMENT_APPLEWATCH = 4,//APPLE Watch端
    XLE_ENVIRONMENT_SAFARY = 5, //safary浏览器
    XLE_ENVIRONMENT_ANDOIRD = 15, //安卓
};

typedef NS_ENUM(int16_t, XLEErrorPlatformType) {
    XLE_PLATFORM_UNKOWN = 0, //未知
    XLE_PLATFORM_PC = 1,//pc端
    XLE_PLATFORM_WEB = 2,//主站
    XLE_PLATFORM_iOS = 3, //iOS
    XLE_PLATFORM_ANDOIRD = 4, //安卓
    XLE_PLATFORM_M = 5, //m站
    XLE_PLATFORM_SERVER = 6, //服务器端
};

extern const int XLE_ERROR_SUBSYSTEM; //3位
extern const int XLE_ERROR_CODE;//4位
extern const int XLE_ERROR_ENVIRONMENT;//2位
extern const int XLE_ERROR_PLATFORM;//2位

@interface XLEError : NSObject
@property (assign, readonly, nonatomic) int16_t environment;//区分运行环境 例如iPhone手机接受到服务器端的错误，则environment为iPhone手机的码 两位数字
@property (assign, readonly, nonatomic) int16_t subsystem; //区分子系统，例如登录系统 最多三位数字
@property (assign, readonly, nonatomic) int16_t platform;//平台维度定义 区分iOS、安卓、pc客户端等等 最多两位数字
@property (assign, readonly, nonatomic) int16_t code; //4位错误码
@property (copy, readonly, nonatomic) NSString *reason;//错误原因
@property (copy, readonly, nonatomic) NSString *fullCode;//完整的错误码，拼接environment、subsystem、platform、code

@property (assign, readonly, nonatomic) NSInteger originalCode;
@property (copy, readonly, nonatomic) NSString *originalReason;

/**
 *  根据一个11位code生成一个XLEError对象
 *
 *  @param fullCode 完整的code码 environment除外 11位code
 *  @param reason   错误原因
 *
 *  @return 生成的对象
 */
+ (nullable XLEError *)errorWithFullCode:(NSString *)fullCode
                                  reason:(NSString *)reason;

+ (XLEError *)errorWithEnvironment:(int16_t)environment
                   subsystem:(int16_t)subsystem
                    platform:(int16_t)platform
                        code:(int16_t)code
                      reason:(NSString *)reason;

+ (XLEError *)errorWithSubsystem:(int16_t)subsystem
                         code:(int16_t)code
                       reason:(NSString *)reason;

+ (XLEError *)errorWithError:(NSError *)error
                   subsystem:(int16_t)subsystem;

@end

NS_ASSUME_NONNULL_END
