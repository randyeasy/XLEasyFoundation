//
//  XLEError.m
//  Pods
//
//  Created by Randy on 15/11/27.
//
//

#import "XLEError.h"
#import "NSString+XLEError.h"
#import "NSString+XLE.h"
#define XLEErrorConfigInstance [XLEErrorConfig sharedInstance]

@interface XLEErrorConfig : NSObject
@property (copy, nonatomic) NSString *domain;
@property (copy, nonatomic) NSString *query;
@property (copy, nonatomic) NSString *subsystem;
@property (copy, nonatomic) NSString *platform;

@end

@implementation XLEErrorConfig

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _domain = @"BJHL-Foundation";
        _query = @"1";
        _subsystem = @"001";
        _platform = @"01";
    }
    return self;
}

@end

@interface XLEError ()

@property (copy, nonatomic) NSString *reason;
@property (assign, nonatomic) XLEErrorInteger code;
@property (copy, nonatomic) NSString *domain;
@property (assign, nonatomic) NSInteger originalCode;
@property (copy, nonatomic) NSString *originalReason;

@end

@implementation XLEError

/**
 *  配置error 的默认选项
 *
 *  @param domain    error
 *  @param query     问题侧
 *  @param subsystem 子系统
 *  @param platform  平台
 */
+ (void)configDefaultWithDomain:(NSString *)domain
                          query:(NSString *)query
                      subsystem:(NSString *)subsystem
                       platform:(NSString *)platform;
{
    XLEErrorConfig *config = [XLEErrorConfig sharedInstance];
    config.domain = domain;
    config.query = query;
    config.subsystem = subsystem;
    config.platform = platform;
}

+ (XLEError *)errorWithDomain:(NSString *)domain code:(XLEErrorInteger)code reason:(NSString *)reason;
{
    XLEError *error = [[XLEError alloc] init];
    error.domain = domain;
    error.code = code;
    error.reason = reason;
    return error;
}

+ (XLEError *)errorWithCode:(XLEErrorInteger)code reason:(NSString *)reason;
{
    return [XLEError errorWithDomain:XLEErrorConfigInstance.domain code:code reason:reason];
}

/**
 *  把本地的code转换为标准的10位code码。 如果本地code会先去掉非数字字符，并转换为4位字符
 *
 *  @param code 本地code，例如：NSError
 *
 *  @return
 */
+ (XLEErrorInteger)errorCodeWithCode:(NSInteger)code
{
    NSString *originalStr = [[NSString stringWithFormat:@"%ld",code] xle_removeNonNumberStr];
    NSString *codeStr = originalStr.length>4?[originalStr substringFromIndex:originalStr.length - 4]:originalStr;
    while (codeStr.length<4) {
        codeStr = [NSString stringWithFormat:@"0%@",codeStr];
    }
    NSString *bjpStr = [NSString stringWithFormat:@"%@%@%@%@",XLEErrorConfigInstance.query,XLEErrorConfigInstance.subsystem,XLEErrorConfigInstance.platform,codeStr];
    return [bjpStr xle_errorIntegerValue];
}

+ (XLEError *)errorWithError:(NSError *)error;
{
    NSString *errorReason = error.localizedFailureReason;
    if (errorReason.length<=0) {
        if ([[error domain] isEqualToString:NSURLErrorDomain]) {
            errorReason = @"网络错误，请检查网络";
        }
        else
            errorReason = @"未知错误";
    }
    XLEError *bjpError = [XLEError errorWithDomain:error.domain code:[XLEError errorCodeWithCode:error.code] reason:errorReason];
    bjpError.originalCode = error.code;
    bjpError.originalReason = error.localizedFailureReason?:error.localizedDescription;
    return bjpError;
}


@end
