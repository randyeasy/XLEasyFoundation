//
//  XLEBlockItem.m
//  Pods
//
//  Created by Randy on 16/3/2.
//
//

#import "XLEBlockItem.h"

@implementation XLEBlockItem

+ (XLEBlockItem *)itemWithTitle:(NSString *)title
                          object:(nullable id<NSObject>)object
                     callback:(nullable void(^)(id<NSObject> _Nullable object))callback;
{
    XLEBlockItem *bockItem = [[XLEBlockItem alloc] init];
    bockItem.title  = title;
    bockItem.object   = object;
    bockItem.handleBlock = callback;
    return bockItem;
}

@end
