
//
//  NSDateFormatter+XLE.h
//  Pods
//
//  Created by Randy on 15/12/31.
//
//

#import "NSDateFormatter+XLE.h"

@implementation NSDateFormatter (XLE)

+ (id)XLE_dateFormatterWithFormat:(NSString *)dateFormat
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)XLE_defaultDayDateFormatter
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = @"yyyy.MM.dd";
    return dateFormatter;
}

+ (id)XLE_defaultDayDateFormatter2
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return dateFormatter;
}

+ (id)XLE_defaultDateFormatter
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}

+ (id)XLE_defaultDateFormatter2
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return dateFormatter;
}

+ (id)XLE_defaultMonthDateFormatter;//yyyy.MM
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = @"yyyy.MM";
    return dateFormatter;
}

+ (id)XLE_defaultMonthDateFormatter2;//yyyy-MM
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = @"yyyy-MM";
    return dateFormatter;
}

+ (id)XLE_defaultMonthDayFormatter;//MM.dd
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = @"MM.dd";
    return dateFormatter;
}

+ (id)XLE_defaultMonthDayFormatter2;//MM-dd
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = @"MM-dd";
    return dateFormatter;
}

+ (id)XLE_defaultMonthDayFormatter3;//MM月dd日
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = @"MM月dd日";
    return dateFormatter;
}

+ (id)XLE_defaultHourFormatter//dd
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = @"dd";
    return dateFormatter;
}

+ (id)XLE_defaultTimeFormatter;
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = @"HH:mm";
    return dateFormatter;
}

@end
