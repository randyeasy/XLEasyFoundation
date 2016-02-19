//
//  NSArray+XLE.m
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import "NSArray+XLE.h"

@implementation NSArray (XLE)
- (NSString *)xle_separateStringWithStr:(NSString *)str;
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

- (id)xle_objectAtIndex:(NSUInteger)index;
{
    if (index >= [self count]) {
        NSAssert2(0, @"越界了 index:%lu, count:%lu", (unsigned long)index, (unsigned long)[self count]);
        return nil;
    }
    return [self objectAtIndex:index];
}

- (BOOL)xle_containsIndex:(NSUInteger)index {
    return index < [self count];
}

- (NSArray *)xle_arrayByRemoveObject:(id)object;
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array removeObject:object];
    return [array copy];
}

- (NSArray *)xle_arrayByRemoveObjectsInArray:(NSArray *)otherArray;
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array removeObjectsInArray:otherArray];
    return [array copy];
}

@end

@implementation NSMutableArray (XLE)

- (void)xle_addObjectNonNil:(id)object
{
    if (object) {
        [self addObject:object];
    }
}

- (void)xle_removeObjectAtIndex:(NSUInteger)index{
    if (index >= [self count]) {
        return;
    }else{
        [self removeObjectAtIndex:index];
    }
}

- (void)xle_insertObjectNonNil:(id)anObject atIndex:(NSUInteger)index{
    if (anObject && index > [self count]) {
        return;
    }
    else{
        [self insertObject:anObject atIndex:index];
    }
}

- (BOOL)replaceObjectAtIndex:(NSUInteger)index withObjectNonNil:(id)anObject {
    if (anObject && index < [self count]) {
        [self replaceObjectAtIndex:index withObject:anObject];
        return YES;
    }
    return NO;
}

@end
