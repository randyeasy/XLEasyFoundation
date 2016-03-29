//
//  NSArray+XLE.m
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import "NSArray+XLE.h"

@implementation NSArray (XLE)
- (NSString *)XLE_separateStringWithStr:(NSString *)str;
{
    NSString *sepStr = str;
    if (sepStr == nil) {
        sepStr = @"";
    }
    NSMutableString *mutStr = [[NSMutableString alloc] initWithCapacity:0];
    for (NSString *oneStr in self) {
        if ([oneStr isKindOfClass:[NSString class]]) {
            [mutStr appendString:oneStr];
            if (oneStr != self.lastObject) {
                [mutStr appendString:sepStr];
            }
        }
        else if ([oneStr isKindOfClass:[NSNumber class]])
        {
            [mutStr appendFormat:@"%@",oneStr];
            if (oneStr != self.lastObject) {
                [mutStr appendString:sepStr];
            }
        }
        else
        {
            NSAssert1(0, @"必须是NSString和NSNumber类型 %s", __FUNCTION__);
        }
    }
    return mutStr;
}

- (id)XLE_objectAtIndex:(NSUInteger)index;
{
#if DEBUG
#else
    if (index >= [self count]) {
        NSAssert2(0, @"越界了 index:%lu, count:%lu", (unsigned long)index, (unsigned long)[self count]);
        return nil;
    }
#endif
    return [self objectAtIndex:index];
}

- (BOOL)XLE_containsIndex:(NSUInteger)index {
    return index < [self count];
}

- (NSArray *)XLE_arrayByRemoveObject:(id)object;
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array removeObject:object];
    return [array copy];
}

- (NSArray *)XLE_arrayByRemoveObjectsInArray:(NSArray *)otherArray;
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array removeObjectsInArray:otherArray];
    return [array copy];
}

@end

@implementation NSMutableArray (XLE)

- (void)XLE_addObjectNonNil:(id)object
{
#if DEBUG
#else
    if (!object) {
        return;
    }
#endif

    [self addObject:object];
}

- (void)XLE_removeObjectAtIndex:(NSUInteger)index{
#if DEBUG
#else
    if (index >= [self count])
        return;
#endif
    [self removeObjectAtIndex:index];
}

- (void)XLE_insertObjectNonNil:(id)anObject atIndex:(NSUInteger)index{
#if DEBUG
#else
    if (anObject && index > [self count])
        return;
#endif
    [self insertObject:anObject atIndex:index];
}

- (BOOL)XLE_replaceObjectAtIndex:(NSUInteger)index withObjectNonNil:(id)anObject {
#if DEBUG
#else
    if (anObject && index < [self count]) {
#endif
        [self replaceObjectAtIndex:index withObject:anObject];
        return YES;
#if DEBUG
#else
    }
#endif
    return NO;
}

@end
