//
//  XLELog.m
//  Pods
//
//  Created by heyingj on 10/30/15.
//

#import "XLELog.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@implementation XLELog

static int gXLELogLevel = XLE_LOG_LEVEL_WARN;
static int ddLogLevel = DDLogLevelVerbose;

+ (void)initialize{
    [XLELog initLogger];
}

+ (void)debug:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    if ((gXLELogLevel & XLE_LOG_FLAG_DEBUG) > 0)
    {
        if (!format) {
            return;
        }
        
        do {
            va_list args;
            va_start(args, format);
            NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
            va_end(args);
            DDLogDebug(@"debug:%@", msg);
        } while (0);
    }
}

+ (void)info:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    if ((gXLELogLevel & XLE_LOG_FLAG_INFO) > 0)
    {
        if (!format) {
            return;
        }
        
        do {
            va_list args;
            va_start(args, format);
            NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
            va_end(args);
            DDLogInfo(@"info:%@", msg);
        } while (0);
    }
}

+ (void)warn:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    if ((gXLELogLevel & XLE_LOG_FLAG_WARN) > 0)
    {
        if (!format) {
            return;
        }
        
        do {
            va_list args;
            va_start(args, format);
            NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
            va_end(args);
            DDLogWarn(@"warn:%@", msg);
        } while (0);
    }
}

+ (void)error:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    if ((gXLELogLevel & XLE_LOG_FLAG_ERROR) > 0)
    {
        if (!format) {
            return;
        }
        
        do {
            va_list args;
            va_start(args, format);
            NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
            va_end(args);
            DDLogError(@"error:%@", msg);
        } while (0);
    }
}

+ (void)errorAndAssert:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
{
    if ((gXLELogLevel & XLE_LOG_FLAG_FATAL) > 0)
    {
        if (!format) {
            return;
        }
        
        do {
            va_list args;
            va_start(args, format);
            NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
            va_end(args);
            DDLogError(@"errorAndAssert:%@", msg);
            NSAssert(0, msg);
        } while (0);
    }
}

+ (void)fatal:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    if ((gXLELogLevel & XLE_LOG_FLAG_FATAL) > 0)
    {
        if (!format) {
            return;
        }
        
        do {
            va_list args;
            va_start(args, format);
            NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
            va_end(args);
            DDLogError(@"fatal:%@", msg);
            NSAssert(0, msg);
        } while (0);
    }
}

+ (void)setLogLevel:(int)logLevel
{
    gXLELogLevel = logLevel;
    [[self class] setDDLogLevel];
}

+ (void)initLogger
{
    // DDLog同一个logger可以加两次，所以先remove再add
    [DDLog removeLogger:[DDASLLogger sharedInstance]];
    [DDLog removeLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[self class] setDDLogLevel];
}

+ (void)setDDLogLevel
{
    ddLogLevel = DDLogLevelOff;
    if ((gXLELogLevel & XLE_LOG_FLAG_DEBUG) > 0) {
        ddLogLevel |= DDLogLevelDebug;
    }
    if ((gXLELogLevel & XLE_LOG_FLAG_INFO) > 0) {
        ddLogLevel |= DDLogLevelInfo;
    }
    if ((gXLELogLevel & XLE_LOG_FLAG_WARN) > 0) {
        ddLogLevel |= DDLogLevelDebug;
    }
    if ((gXLELogLevel & XLE_LOG_FLAG_ERROR) > 0) {
        ddLogLevel |= DDLogLevelError;
    }
    if ((gXLELogLevel & XLE_LOG_FLAG_FATAL) > 0) {
        ddLogLevel |= DDLogLevelError;
    }
}

@end
