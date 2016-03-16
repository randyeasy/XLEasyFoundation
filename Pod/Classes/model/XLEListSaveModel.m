//
//  BJPListSaveModel.m
//  Pods
//
//  Created by Randy on 16/3/14.
//
//

#import "XLEListSaveModel.h"

@interface XLEListSaveModel ()
@property (strong, nonatomic) NSMutableArray *list;
@property (copy, nonatomic) NSString *cachePath;
@end

@implementation XLEListSaveModel

+ (instancetype)listSaveWithCachePath:(NSString *)cachePath
{
    XLEListSaveModel *save = [[XLEListSaveModel alloc] initWithCachePath:cachePath];
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

- (void)removeAllObjects
{
    [self.list removeAllObjects];
    [self saveData];
}

- (void)removeObjects:(NSArray<id<NSObject>> *)objects
{
    if (objects.count<=0) {
        return;
    }
    [self.list removeObjectsInArray:objects];
    [self saveData];
}

- (void)addObjects:(NSArray<id<NSObject>> *)objects
{
    if (objects.count<=0) {
        return;
    }
    [self.list addObjectsFromArray:objects];
    [self saveData];
}

- (void)removeObject:(id<NSObject>)object
{
    if (!object) {
        return;
    }
    [self.list removeObject:object];
    [self saveData];
}

- (void)addObject:(id<NSObject>)object
{
    if (!object) {
        return;
    }
    [self.list addObject:object];
    [self saveData];
}

- (id)objectAtIndex:(NSInteger)index
{
    if (self.list.count > index) {
        return [self.list objectAtIndex:index];
    }
    return nil;
}

- (void)moveObjectToLastWithObject:(id<NSObject>)object;
{
    if ([self.list containsObject:object]) {
        id<NSObject> theObject = object;
        [self.list removeObject:theObject];
        [self.list addObject:theObject];
        [self saveData];
    }
}

- (NSUInteger)count;{
    return self.list.count;
}

#pragma mark - internal
- (void)saveData
{
    NSString *filePath = self.cachePath;
    [NSKeyedArchiver archiveRootObject:self.list toFile:filePath];
}

- (NSMutableArray *)loadData
{
    NSString *filePath = self.cachePath;
    NSArray *list = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    return list?[list mutableCopy]:[NSMutableArray new];
}

#pragma mark - set get
- (NSMutableArray *)list{
    if (_list == nil) {
        _list = [self loadData];
    }
    return _list;
}

@end
