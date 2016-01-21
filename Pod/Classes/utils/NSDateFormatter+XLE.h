
#import <Foundation/Foundation.h>

@interface NSDateFormatter (XLE)

+ (id)xle_dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)xle_defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/
+ (id)xle_defaultDateFormatter2;/*yyyy-MM-dd HH:mm*/

+ (id)xle_defaultDayDateFormatter;//yyyy.MM.dd
+ (id)xle_defaultDayDateFormatter2;//yyyy-MM-dd

+ (id)xle_defaultMonthDateFormatter;//yyyy.MM
+ (id)xle_defaultMonthDateFormatter2;//yyyy-MM

+ (id)xle_defaultMonthDayFormatter;//MM.dd
+ (id)xle_defaultMonthDayFormatter2;//MM-dd
+ (id)xle_defaultMonthDayFormatter3;//MM月dd日

+ (id)xle_defaultHourFormatter;//dd
+ (id)xle_defaultTimeFormatter;//HH:mm

@end
