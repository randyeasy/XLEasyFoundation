
//
//  NSDateFormatter+XLE.h
//  Pods
//
//  Created by Randy on 15/12/31.
//
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (XLE)

+ (id)XLE_dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)XLE_defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/
+ (id)XLE_defaultDateFormatter2;/*yyyy-MM-dd HH:mm*/

+ (id)XLE_defaultDayDateFormatter;//yyyy.MM.dd
+ (id)XLE_defaultDayDateFormatter2;//yyyy-MM-dd

+ (id)XLE_defaultMonthDateFormatter;//yyyy.MM
+ (id)XLE_defaultMonthDateFormatter2;//yyyy-MM

+ (id)XLE_defaultMonthDayFormatter;//MM.dd
+ (id)XLE_defaultMonthDayFormatter2;//MM-dd
+ (id)XLE_defaultMonthDayFormatter3;//MM月dd日

+ (id)XLE_defaultHourFormatter;//dd
+ (id)XLE_defaultTimeFormatter;//HH:mm

@end
