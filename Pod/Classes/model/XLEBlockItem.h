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
@property (strong, nonatomic) id<NSObject> object;
@property (copy, nonatomic) void(^handleBlock)();

+ (XLEBlockItem *)itemWithTitle:(NSString *)title
                           object:(nullable id<NSObject>)object
                       callback:(nullable void(^)(id<NSObject> _Nullable object))callback;
@end

NS_ASSUME_NONNULL_END
