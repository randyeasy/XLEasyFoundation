/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <Foundation/Foundation.h>

@interface NSDateFormatter (XLE)

+ (id)xle_dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)xle_dateFormatter;//yyyy.MM.dd
+ (id)xle_defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/
+ (id)xle_defaultDateFormatter2;/*yyyy-MM-dd HH:mm*/
+ (id)xle_defaultDayDateFormatter;//yyyy.MM.dd
+ (id)xle_defaultDayDateFormatter2;//yyyy-MM-dd
+ (id)xle_defaultOnlyHourDateFormatter;//dd
+ (id)xle_defaultTimeDateFormatter;//HH:mm

@end
