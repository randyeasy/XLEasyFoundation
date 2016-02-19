//
//  NSArray+XLE.h
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (XLE)
- (NSString *)xle_separateStringWithStr:(NSString *)str;
- (id)xle_objectAtIndex:(NSUInteger)index;
- (BOOL)xle_containsIndex:(NSUInteger)index;
- (NSArray *)xle_arrayByRemoveObject:(id)object;
- (NSArray *)xle_arrayByRemoveObjectsInArray:(NSArray *)array;
@end

@interface NSMutableArray (XLE)

- (void)xle_addObjectNonNil:(id)object;
- (void)xle_removeObjectAtIndex:(NSUInteger)index;
- (void)xle_insertObjectNonNil:(id)anObject atIndex:(NSUInteger)index;
- (BOOL)replaceObjectAtIndex:(NSUInteger)index withObjectNonNil:(id)anObject;

@end
