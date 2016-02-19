//
//  NSURL+Query.h
//  NSURL+Query
//
//  Created by Jon Crooke on 10/12/2013.
//  Copyright (c) 2013 Jonathan Crooke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (XLEURLQuery)

/**
 *  @return URL's query component as keys/values
 *  Returns nil for an empty query
 */
- (NSDictionary*)xle_queryDictionary;

/**
 *  @return URL with keys values appending to query string
 *  @param queryDictionary Query keys/values
 *  @param sortedKeys Sorted the keys alphabetically?
 *  @warning If keys overlap in receiver and query dictionary,
 *  behaviour is undefined.
 */
- (NSURL*)xle_URLByAppendingQueryDictionary:(NSDictionary*) queryDictionary
                             withSortedKeys:(BOOL) sortedKeys;

/** As above, but `sortedKeys=NO` */
- (NSURL*)xle_URLByAppendingQueryDictionary:(NSDictionary*) queryDictionary;

@end

#pragma mark -

@interface NSString (XLEURLQuery)

/**
 *  @return If the receiver is a valid URL query component, returns
 *  components as key/value pairs. If couldn't split into *any* pairs,
 *  returns nil.
 */
- (NSDictionary*)xle_URLQueryDictionary;

@end

#pragma mark -

@interface NSDictionary (XLEURLQuery)

/**
 *  @return URL query string component created from the keys and values in
 *  the dictionary. Returns nil for an empty dictionary.
 *  @param sortedKeys Sorted the keys alphabetically?
 *  @see cavetas from the main `NSURL` category as well.
 */
- (NSString*)xle_URLQueryStringWithSortedKeys:(BOOL) sortedKeys;

/** As above, but `sortedKeys=NO` */
- (NSString*)xle_URLQueryString;

@end
