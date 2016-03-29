//
//  XLELog.h
//  Pods
//
//  Created by heyingj on 10/30/15.
//

#import <Foundation/Foundation.h>

#define XLE_LOG_FLAG_DEBUG    (1 << 0)  // 0...00001
#define XLE_LOG_FLAG_INFO     (1 << 1)  // 0...00010
#define XLE_LOG_FLAG_WARN     (1 << 2)  // 0...00100
#define XLE_LOG_FLAG_ERROR    (1 << 3)  // 0...01000
#define XLE_LOG_FLAG_FATAL    (1 << 4)  // 0...10000

/**
 *  日志级别宏
 */
#define XLE_LOG_LEVEL_OFF     0
#define XLE_LOG_LEVEL_DEBUG   (XLE_LOG_FLAG_DEBUG | XLE_LOG_FLAG_INFO | XLE_LOG_FLAG_WARN | XLE_LOG_FLAG_ERROR | XLE_LOG_FLAG_FATAL)
#define XLE_LOG_LEVEL_INFO    (XLE_LOG_FLAG_INFO | XLE_LOG_FLAG_WARN | XLE_LOG_FLAG_ERROR | XLE_LOG_FLAG_FATAL)
#define XLE_LOG_LEVEL_WARN    (XLE_LOG_FLAG_WARN | XLE_LOG_FLAG_ERROR | XLE_LOG_FLAG_FATAL)
#define XLE_LOG_LEVEL_ERROR   (XLE_LOG_FLAG_ERROR | XLE_LOG_FLAG_FATAL)
#define XLE_LOG_LEVEL_FATAL   (XLE_LOG_FLAG_FATAL)

/**
 *  日志输出宏
 */
#define XLELogDebug(fmt, ...) do {[XLELog debug:fmt, ##__VA_ARGS__];} while (0)
#define XLELogInfo(fmt, ...) do {[XLELog info:fmt, ##__VA_ARGS__];} while (0)
#define XLELogWarn(fmt, ...) do {[XLELog warn:fmt, ##__VA_ARGS__];} while (0)
#define XLELogError(fmt, ...) do {[XLELog error:fmt, ##__VA_ARGS__];} while (0)
#define XLELogFatal(fmt, ...) do {[XLELog fatal:fmt, ##__VA_ARGS__];} while (0)
#define XLELogErrorAndAssert(fmt, ...) do {[XLELog errorAndAssert:fmt, ##__VA_ARGS__];} while (0)
#define XLELogTrace() XLELogDebug(@"函数调用：%s",__FUNCTION__)

/**
 *  日志类
 */
@interface XLELog : NSObject

/**
 *  调试信息
 *
 *  @param format
 *  @param ...
 */
+ (void)debug:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 *  运行状态、监测信息
 *
 *  @param format
 *  @param ...
 */
+ (void)info:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 *  警告信息、隐患信息
 *
 *  @param format
 *  @param ...
 */
+ (void)warn:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 *  错误信息，系统继续运行
 *
 *  @param format
 *  @param ...
 */
+ (void)error:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 *  错误信息，系统继续运行，在调试状态错误需要解决 会有断言
 *
 *  @param format
 *  @param ...
 */
+ (void)errorAndAssert:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 *  严重错误，导致系统崩溃
 *
 *  @param format
 *  @param ...
 */
+ (void)fatal:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 *  设置日志级别 默认 XLE_LOG_LEVEL_WARN
 *
 *  @param logLevel 日志级别
 */
+ (void)setLogLevel:(int)logLevel;

@end
