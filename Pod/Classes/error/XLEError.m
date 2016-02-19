//
//  XLEError.m
//  Pods
//
//  Created by Randy on 15/11/27.
//
//

#import "XLEError.h"
#import "NSString+XLE.h"
#import "UIDevice+XLE.h"

const int XLE_ERROR_SUBSYSTEM   = 3;
const int XLE_ERROR_CODE        = 4;
const int XLE_ERROR_ENVIRONMENT = 2;
const int XLE_ERROR_PLATFORM    = 2;

@interface XLEError ()

@property (assign, nonatomic) int16_t code; //4位错误码
@property (copy, nonatomic) NSString *reason;//错误原因
@property (assign, nonatomic) int16_t subsystem; //区分子系统，例如登录系统 最多三位数字
@property (assign, nonatomic) int16_t environment;//区分运行环境 例如iPhone手机接受到服务器端的错误，则environment为iPhone手机的码 两位数字
@property (assign, nonatomic) int16_t platform;//平台维度定义 区分iOS、安卓、pc客户端等等 最多两位数字

@property (strong, nonatomic) NSError *originalError;

@end

@implementation XLEError

- (instancetype)init
{
    self = [super init];
    if (self) {
        _code = XLE_ERROR_UNKNOWN;
    }
    return self;
}

+ (nullable XLEError *)errorWithFullCode:(NSString *)fullCode reason:(NSString *)reason;
{
    if (fullCode.length  > [self fullCodeNum]) {
        NSString *code = [fullCode substringWithRange:NSMakeRange(fullCode.length - XLE_ERROR_CODE, XLE_ERROR_CODE)];
        fullCode = [fullCode substringToIndex:fullCode.length - XLE_ERROR_CODE];
        NSString *platform = [fullCode substringWithRange:NSMakeRange(fullCode.length - XLE_ERROR_PLATFORM, XLE_ERROR_PLATFORM)];
        fullCode = [fullCode substringToIndex:fullCode.length - XLE_ERROR_PLATFORM];
        NSString *subsystem = [fullCode substringWithRange:NSMakeRange(fullCode.length - XLE_ERROR_SUBSYSTEM, XLE_ERROR_SUBSYSTEM)];
        fullCode = [fullCode substringToIndex:fullCode.length - XLE_ERROR_SUBSYSTEM];
        NSString *env = [fullCode substringWithRange:NSMakeRange(fullCode.length - XLE_ERROR_ENVIRONMENT, XLE_ERROR_ENVIRONMENT)];
        return [self errorWithEnvironment:[env xle_int16Value] subsystem:[subsystem xle_int16Value] platform:[platform xle_int16Value] code:[code xle_int16Value] reason:reason];
    }
    return nil;
}

+ (XLEError *)errorWithEnvironment:(int16_t)environment
                         subsystem:(int16_t)subsystem
                          platform:(int16_t)platform
                              code:(int16_t)code
                            reason:(NSString *)reason;
{
    XLEError *error = [[XLEError alloc] init];
    error.environment = environment;
    error.subsystem = subsystem;
    error.platform = platform;
    error.code = code;
    error.reason = reason;
    return error;
}

+ (XLEError *)errorWithSubsystem:(int16_t)subsystem
                            code:(int16_t)code
                          reason:(NSString *)reason;
{

    return [XLEError errorWithEnvironment:[self environmentType] subsystem:subsystem platform:XLE_PLATFORM_iOS code:code reason:reason];
}

+ (XLEError *)errorWithError:(NSError *)error
                   subsystem:(int16_t)subsystem;
{
    //TODO error转换 特殊处理
    NSString *errorReason = error.localizedFailureReason;
    if (errorReason.length<=0) {
        if ([[error domain] isEqualToString:NSURLErrorDomain]) {
            errorReason = @"网络错误，请检查网络";
        }
        else
            errorReason = @"未知错误";
    }
    XLEError *xleError = [XLEError errorWithEnvironment:[self environmentType] subsystem:subsystem platform:XLE_PLATFORM_iOS code:error.code reason:error.localizedFailureReason];
    xleError.originalError = error;
    return xleError;
}

#pragma mark - internal

- (NSString *)description
{
    return [NSString stringWithFormat:@"reason:%@, envi:%d, subsystem:%d, platform:%d, code:%d", self.reason, self.environment, self.subsystem, self.platform, self.code];
}

#pragma mark - set get
+ (XLEErrorEnvironmentType)environmentType
{
    XLEErrorEnvironmentType environment = XLE_ENVIRONMENT_UNKOWN;
    switch ([UIDevice xle_deviceFamily]) {
        case XLE_DEVICE_UNKONW: {
            environment = XLE_ENVIRONMENT_UNKOWN;
            break;
        }
        case XLE_DEVICE_IPHONE: {
            environment = XLE_ENVIRONMENT_IPHONE;
            break;
        }
        case XLE_DEVICE_IPAD: {
            environment = XLE_ENVIRONMENT_IPHONE;
            break;
        }
        case XLE_DEVICE_APPLETV: {
            environment = XLE_ENVIRONMENT_APPLETV;
            break;
        }
        case XLE_DEVICE_APPLEWATCH: {
            environment = XLE_ENVIRONMENT_APPLEWATCH;
            break;
        }
    }
    return environment;
}

+ (NSInteger)fullCodeNum
{
    return XLE_ERROR_CODE + XLE_ERROR_ENVIRONMENT + XLE_ERROR_PLATFORM + XLE_ERROR_SUBSYSTEM;
}

- (NSString *)fullCode{
    NSString *environment = [NSString xle_fillZero:self.environment toEnoughBit:XLE_ERROR_ENVIRONMENT];
    NSString *subsystem = [NSString xle_fillZero:self.subsystem toEnoughBit:XLE_ERROR_SUBSYSTEM];
    NSString *platform = [NSString xle_fillZero:self.platform toEnoughBit:XLE_ERROR_PLATFORM];
    NSString *code = [NSString xle_fillZero:self.code toEnoughBit:XLE_ERROR_CODE];
    return [NSString stringWithFormat:@"%@%@%@%@",environment,subsystem,platform,code];
}

- (NSString *)originalReason{
    return self.originalError.localizedFailureReason;
}

- (NSInteger)originalCode{
    return self.originalError.code;
}

@end
