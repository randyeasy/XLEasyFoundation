//
//  NSURL+Query.m
//  NSURL+Query
//
//  Created by Jon Crooke on 10/12/2013.
//  Copyright (c) 2013 Jonathan Crooke. All rights reserved.
//

// from https://github.com/itsthejb/NSURL-QueryDictionary.git

#import "NSURL+XLEURLQuery.h"

NSString *const XLE_URLReservedChars     = @"￼=,!$&'()*+;@?\r\n\"<>#\t :/";
static NSString *const kQuerySeparator  = @"&";
static NSString *const kQueryDivider    = @"=";
static NSString *const kQueryBegin      = @"?";
static NSString *const kFragmentBegin   = @"#";

@implementation NSURL (XLEURLQuery)

- (NSDictionary*) XLE_queryDictionary {
  return self.query.XLE_URLQueryDictionary;
}

- (NSURL*) XLE_URLByAppendingQueryDictionary:(NSDictionary*) queryDictionary {
  return [self XLE_URLByAppendingQueryDictionary:queryDictionary withSortedKeys:NO];
}

- (NSURL *)XLE_URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary
                          withSortedKeys:(BOOL)sortedKeys
{
  NSMutableArray *queries = [self.query length] > 0 ? @[self.query].mutableCopy : @[].mutableCopy;
  NSString *dictionaryQuery = [queryDictionary XLE_URLQueryStringWithSortedKeys:sortedKeys];
  if (dictionaryQuery) {
    [queries addObject:dictionaryQuery];
  }
  NSString *newQuery = [queries componentsJoinedByString:kQuerySeparator];

  if (newQuery.length) {
    NSArray *queryComponents = [self.absoluteString componentsSeparatedByString:kQueryBegin];
    if (queryComponents.count) {
    //fix:queryComponents[0] contain fragment bugs
    NSString *eurl = queryComponents[0];
    NSRange frameRang= [eurl rangeOfString:[NSString stringWithFormat:@"%@%@",kFragmentBegin,self.fragment]];
     if (frameRang.length>0) {
         eurl = [eurl stringByReplacingCharactersInRange:frameRang withString:@""];
     }
     //end fix
      return [NSURL URLWithString:
              [NSString stringWithFormat:@"%@%@%@%@%@",
               eurl,                      // existing url
               kQueryBegin,
               newQuery,
               self.fragment.length ? kFragmentBegin : @"",
               self.fragment.length ? self.fragment : @""]];
    }
  }
  return self;
}

- (NSArray *)XLE_pathComponents;
{
    NSArray *paths = [self pathComponents];
    NSMutableArray *mutPaths = [paths mutableCopy];
    for (NSString *onePath in paths) {
        if ([onePath isEqualToString:@"/"]) {
            [mutPaths removeObject:onePath];
        }
    }
    return [mutPaths copy];
}

@end

#pragma mark -

@implementation NSString (URLQuery)

- (NSDictionary*) XLE_URLQueryDictionary {
  NSMutableDictionary *mute = @{}.mutableCopy;
  for (NSString *query in [self componentsSeparatedByString:kQuerySeparator]) {
    NSArray *components = [query componentsSeparatedByString:kQueryDivider];
    if (components.count == 0) {
      continue;
    }
    NSString *key = [components[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    id value = nil;
    if (components.count == 1) {
      // key with no value
    }
    if (components.count == 2) {
      value = [components[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    if (components.count > 2) {
      // invalid - ignore this pair. is this best, though?
      continue;
    }
      if (value) {
          mute[key] = value;
      }
  }
  return mute.count ? mute.copy : nil;
}

@end

#pragma mark -

@implementation NSDictionary (URLQuery)

static inline NSString *XLE_URLEscape(NSString *string);

- (NSString *)XLE_URLQueryString {
  return [self XLE_URLQueryStringWithSortedKeys:NO];
}

- (NSString*) XLE_URLQueryStringWithSortedKeys:(BOOL)sortedKeys {
  NSMutableString *queryString = @"".mutableCopy;
  NSArray *keys = sortedKeys ? [self.allKeys sortedArrayUsingSelector:@selector(compare:)] : self.allKeys;
  for (NSString *key in keys) {
    id rawValue = self[key];
    NSString *value = nil;
    // beware of empty or null
    if (!(rawValue == [NSNull null] || ![rawValue description].length)) {
      value = XLE_URLEscape([self[key] description]);
    }
    [queryString appendFormat:@"%@%@%@%@",
     queryString.length ? kQuerySeparator : @"",    // appending?
     XLE_URLEscape(key),
     value ? kQueryDivider : @"",
     value ? value : @""];
  }
  return queryString.length ? queryString.copy : nil;
}

static inline NSString *XLE_URLEscape(NSString *string) {
    return ((__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
        NULL,
        (__bridge CFStringRef)string,
        NULL,
        (__bridge CFStringRef)XLE_URLReservedChars,
        kCFStringEncodingUTF8));
}

@end
