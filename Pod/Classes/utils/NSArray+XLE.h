//
//  NSArray+XLE.h
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import <Foundation/Foundation.h>

/**
 *  对Array进行保护访问 DEBUG==0下生效,非0下不生效
 */

@interface NSArray (XLE)
- (NSString *)XLE_separateStringWithStr:(NSString *)str;
- (id)XLE_objectAtIndex:(NSUInteger)index;
- (BOOL)XLE_containsIndex:(NSUInteger)index;
- (NSArray *)XLE_arrayByRemoveObject:(id)object;
- (NSArray *)XLE_arrayByRemoveObjectsInArray:(NSArray *)array;
@end

@interface NSMutableArray (XLE)

- (void)XLE_addObjectNonNil:(id)object;
- (void)XLE_removeObjectAtIndex:(NSUInteger)index;
- (void)XLE_insertObjectNonNil:(id)anObject atIndex:(NSUInteger)index;
- (BOOL)XLE_replaceObjectAtIndex:(NSUInteger)index withObjectNonNil:(id)anObject;

@end
