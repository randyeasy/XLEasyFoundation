//
//  NSString+XLESize.m
//  Pods
//
//  Created by Randy on 15/12/5.
//
//

#import "NSString+XLESize.h"

@implementation NSString (XLESize)

- (CGSize)xle_maxSizeWithConstrainedSize:(CGSize)size font:(UIFont *)font lineMode:(NSLineBreakMode)lineMode
{
    float width = 0.0;
    float height = 0.0;
    CGSize labsize = CGSizeZero;
    NSString *strString = self;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        labsize = [strString sizeWithFont:font constrainedToSize:size lineBreakMode:lineMode];
    }
    else
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = lineMode;
        
        labsize = [strString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil] context:nil].size;
    }
    
    width = labsize.width;
    height = labsize.height;
    return CGSizeMake(ceil(width), ceil(height));
}

@end
