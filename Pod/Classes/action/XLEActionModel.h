//
//  XLEActionModel.h
//  Pods
//
//  Created by Randy on 16/3/18.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLEActionModel : NSObject
@property (copy, readonly, nonatomic) NSString *scheme;
@property (copy, readonly, nonatomic) NSString *host;
@property (copy, readonly, nullable, nonatomic) NSString *subPath;
@property (copy, readonly, nonatomic) NSString *name;

- (instancetype)initWithUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
