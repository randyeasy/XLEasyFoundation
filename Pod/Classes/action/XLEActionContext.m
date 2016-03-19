//
//  XLEActionContext.m
//  Pods
//
//  Created by Randy on 16/3/19.
//
//

#import "XLEActionContext.h"

@interface XLEActionContext ()
@property (assign, nonatomic) XLEActionSourceType sourceType;
@property (strong, nullable, nonatomic) UINavigationController *navi;

@end

@implementation XLEActionContext

+ (instancetype)contextWithSourceType:(XLEActionSourceType)sourceType
                                 navi:(UINavigationController *)navi;
{
    XLEActionContext *context = [[XLEActionContext alloc] init];
    context.navi = navi;
    context.sourceType = sourceType;
    return context;
}

@end
