//
//  XLEActionContext.h
//  Pods
//
//  Created by Randy on 16/3/19.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XLEActionSourceType) {
    XLE_ACTION_SOURCE_NATIVE,//本地调用
    XLE_ACTION_SOURCE_WEB,//应用内部 web控件调用
    XLE_ACTION_SOURCE_EXTENAL,//应用外部调用
};

@interface XLEActionContext : NSObject
@property (assign, readonly, nonatomic) XLEActionSourceType sourceType;
@property (strong, readonly, nullable, nonatomic) UINavigationController *navi;

+ (instancetype)contextWithSourceType:(XLEActionSourceType)sourceType
                                 navi:(nullable UINavigationController *)navi;

@end

NS_ASSUME_NONNULL_END
