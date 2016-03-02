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
                          item:(nullable id<NSObject>)item
                     callback:(void(^)())callback;
{
    XLEBlockItem *bockItem = [[XLEBlockItem alloc] init];
    bockItem.title  = title;
    bockItem.item   = item;
    bockItem.handleBlock = callback;
    return bockItem;
}

@end
