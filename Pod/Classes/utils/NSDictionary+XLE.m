//
//  NSDictionary+XLE.m
//  Pods
//
//  Created by Randy on 16/3/30.
//
//

#import "NSDictionary+XLE.h"

@implementation NSDictionary (XLE)

- (NSDictionary *)XLE_addEntriesFromDictionary:(nullable NSDictionary *)entries
{
    if (entries.count>0) {
        NSMutableDictionary *mutDic = [self mutableCopy];
        [mutDic addEntriesFromDictionary:entries];
        return [mutDic copy];
    }
    return self;
}

@end
