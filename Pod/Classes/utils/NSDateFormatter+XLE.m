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

#import "NSDateFormatter+XLE.h"

@implementation NSDateFormatter (XLE)

+ (id)xle_dateFormatter
{
    static NSDateFormatter *dateFormate= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormate = [[NSDateFormatter alloc] init];
    });
    return dateFormate;
}

+ (id)xle_dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [self xle_dateFormatter];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)xle_defaultDayDateFormatter
{
    NSDateFormatter *dayDateFormatter = [self xle_dateFormatter];
    dayDateFormatter.dateFormat = @"yyyy.MM.dd";
    return dayDateFormatter;
}

+ (id)xle_defaultDayDateFormatter2
{
    NSDateFormatter *dayDateFormatter = [self xle_dateFormatter];
    dayDateFormatter.dateFormat = @"yyyy-MM-dd";
    return dayDateFormatter;
}

+ (id)xle_defaultDateFormatter
{
    NSDateFormatter *dateFormatter = [self xle_dateFormatter];
   dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}

+ (id)xle_defaultDateFormatter2
{
    NSDateFormatter *dateFormatter = [self xle_dateFormatter];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return dateFormatter;
}

+ (id)xle_defaultOnlyHourDateFormatter//dd
{
    NSDateFormatter *dateFormatter = [self xle_dateFormatter];
    dateFormatter.dateFormat = @"dd";
    return dateFormatter;
}

+ (id)xle_defaultTimeDateFormatter;
{
    NSDateFormatter *dateFormatter = [self xle_dateFormatter];
    dateFormatter.dateFormat = @"HH:mm";
    return dateFormatter;
}

@end
