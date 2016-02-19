//
//  NSString+XLEEncoding.h
//  Pods
//
//  Created by Randy on 16/2/19.
//
//

#import <Foundation/Foundation.h>

@interface NSString (XLEEncoding)

- (NSString *)xle_urlEncodedString;
- (NSString *)xle_urlDecodedString;

@end
