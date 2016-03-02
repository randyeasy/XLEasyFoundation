//
//  XLEBlockItem.h
//  Pods
//
//  Created by Randy on 16/3/2.
//
//

#import <XLEasyFoundation/XLEasyFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLEBlockItem : XLEModel
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) id<NSObject> item;
@property (copy, nonatomic) void(^handleBlock)();

+ (XLEBlockItem *)itemWithTitle:(NSString *)title
                           item:(nullable id<NSObject>)item
                       callback:(void(^)())callback;
@end

NS_ASSUME_NONNULL_END
