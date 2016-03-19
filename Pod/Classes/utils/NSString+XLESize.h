//
//  NSString+XLESize.h
//  Pods
//
//  Created by Randy on 15/12/5.
//
//

#import <Foundation/Foundation.h>

@interface NSString (XLESize)

- (CGSize)XLE_maxSizeWithConstrainedSize:(CGSize)size font:(UIFont *)font lineMode:(NSLineBreakMode)lineMode;

@end
