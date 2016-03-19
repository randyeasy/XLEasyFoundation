//
//  XLEActionModel.m
//  Pods
//
//  Created by Randy on 16/3/18.
//
//

#import "XLEActionModel.h"
#import "NSURL+XLEURLQuery.h"

@implementation XLEActionModel

- (instancetype)initWithUrl:(NSURL *)url;
{
    self = [super init];
    if (self) {
        _scheme = [url scheme];
        _host = [url host];
        NSArray *paths = [url XLE_pathComponents];
        
        if (paths.count>1) {
            _subPath = [paths objectAtIndex:0];
            _name = [paths objectAtIndex:1];
        }
        else if (paths.count==1)
        {
            _name = paths.lastObject;
        }
        else{
            NSAssert1(0, @"url解析失败，没有拿到跳转的name url:%@", url);
        }
    }
    return self;
}

@end
