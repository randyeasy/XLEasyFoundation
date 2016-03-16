//
//  BJPDictionarySaveModel.m
//  Pods
//
//  Created by Randy on 16/3/14.
//
//

#import "XLEDictionarySaveModel.h"

@interface XLEDictionarySaveModel ()
@property (strong, nonatomic) NSMutableDictionary *dic;
@property (copy, nonatomic) NSString *cachePath;
@end

@implementation XLEDictionarySaveModel

+ (instancetype)dictionarySaveWithCachePath:(NSString *)cachePath
{
    XLEDictionarySaveModel *save = [[XLEDictionarySaveModel alloc] initWithCachePath:cachePath];
    return save;
}

- (instancetype)initWithCachePath:(NSString *)cachePath
{
    self = [super init];
    if (self) {
        _cachePath = cachePath;
    }
    return self;
}

- (void)setObject:(id<NSObject>)object forKey:(nonnull id<NSCopying>)key
{
    if (!key) {
        return;
    }
    if (object) {
        [self.dic setObject:object forKey:key];
        [self saveData];
    }
    else{
        [self removeObjectForKey:key];
    }
}

- (void)removeObjectForKey:(nonnull id<NSCopying>)key
{
    if (!key) {
        return;
    }
    [self.dic removeObjectForKey:key];
    [self saveData];
}

- (void)addEntriesFromDictionary:(NSDictionary *)dictionary
{
    if (dictionary.count<=0) {
        return;
    }
    [self.dic addEntriesFromDictionary:dictionary];
    [self saveData];
}

- (void)removeObjectsForKeys:(NSArray *)list
{
    if (list.count<=0) {
        return;
    }
    [self.dic removeObjectsForKeys:list];
    [self saveData];
}

- (void)removeAllObjects
{
    [self.dic removeAllObjects];
    [self saveData];
}

- (id)objectForKey:(nonnull id<NSCopying>)key
{
    return [self.dic objectForKey:key];
}

- (NSUInteger)count;
{
    return self.dic.count;
}


#pragma mark - internal

- (void)saveData
{
    [NSKeyedArchiver archiveRootObject:self.dic toFile:self.cachePath];
}

- (NSMutableDictionary *)loadData
{
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:self.cachePath];
    
    return dic?[dic mutableCopy]:[NSMutableDictionary new];
}

#pragma mark - set get
- (NSMutableDictionary *)dic{
    if (_dic == nil) {
        _dic = [self loadData];
    }
    return _dic;
}

@end
