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

#import "NSDate+XLE.h"
#import "NSDateFormatter+XLE.h"

#define XLEDATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define XLECURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (XLE)

/*距离当前的时间间隔描述*/
- (NSString *)xle_timeIntervalDescription
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
	if (timeInterval < 60) {
        return @"1分钟内";
	} else if (timeInterval < 3600) {
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
	} else if (timeInterval < 86400) {
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / 3600];
	} else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:@"%.f天前", timeInterval / 86400];
    } else if (timeInterval < 31536000) {//30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"M月d日"];
        return [dateFormatter stringFromDate:self];
    } else {
        return [NSString stringWithFormat:@"%.f年前", timeInterval / 31536000];
    }
}

/*精确到分钟的日期描述*/
- (NSString *)xle_minuteDescription
{
    NSDateFormatter *dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"yyyy-MM-dd"];
    
	NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
	NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    if ([theDay isEqualToString:currentDay]) {//当天
		[dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
	} else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < 86400 * 7) {//间隔一周内
        [dateFormatter setDateFormat:@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else {//以前
		[dateFormatter setDateFormat:@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:self];
	}
}

/**
 *  @author LiangZhao, 15-09-23 16:09:17
 *
 *  测试代码
 *   
    NSArray *testList = @[@"2014-09-20 23:20:10",@"2015-09-20 23:20:10", @"2015-09-21 23:20:10",@"2015-09-21 00:20:10",@"2015-09-21 01:20:10",@"2015-09-21 00:00:00",@"2015-09-22 23:20:10",@"2015-09-22 00:20:10",@"2015-09-22 01:20:10",@"2015-09-22 00:00:00",@"2015-09-23 00:20:10",@"2015-09-23 23:20:10",@"2015-09-23 01:20:10",@"2015-09-23 00:00:00"];
    for (NSString *oneStr in testList)
    {
        NSDate *date = [[NSDateFormatter defaultDateFormatter] dateFromString:oneStr];
        NSLog(@"date:%@ 转换：%@",oneStr,[date formattedTime]);
    }
 *
 */
- (NSInteger) xle_maxHoursAfterDate:(NSDate *)date
{
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    NSInteger hour = 0;
    NSTimeInterval hi = ti / D_HOUR;
    if (ti>=0) {
        hour = ceil(hi);
    }
    else
        hour = -ceil(fabs(hi));
    return hour;
}

- (BOOL)xle_isAMPM
{
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    return hasAMPM;
}

/**
 *  根据传入的 ampm/24 区别返回不同的时间格式化数据
 *
 *  @param isAMPM 是上下午的 YES
 *
 *  @return 返回格式化好的字符串
 */
- (NSString *)xle_formattedTimeWithAMPM:(BOOL)isAMPM
{
    NSDateFormatter* formatter = [NSDateFormatter xle_dateFormatter];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(6,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(4,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    
    NSInteger hour = [self xle_maxHoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    BOOL hasAMPM = isAMPM;
    
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"HH:mm"];
        }else if (hour < 0 && hour >= -24) {
            dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"昨天HH:mm"];
        }else {
            dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"yyyy-MM-dd"];
        }
    }else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"凌晨hh:mm"];
        }else if (hour > 6 && hour <=12 ) {
            dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"上午hh:mm"];
        }else if (hour > 12 && hour <= 18) {
            dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"下午hh:mm"];
        }else if (hour > 18 && hour <= 24) {
            dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"晚上hh:mm"];
        }else if (hour < 0 && hour >= -24){
            dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"昨天HH:mm"];
        }else  {
            dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"yyyy-MM-dd"];
        }
    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

/*标准时间日期描述*/
-(NSString *)xle_formattedTime
{
    return [self xle_formattedTimeWithAMPM:[self xle_isAMPM]];
}


/*格式化日期描述*/
- (NSString *)xle_formattedDateDescription
{
    NSDateFormatter *dateFormatter = [NSDateFormatter xle_dateFormatter];
    
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
	NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    
    NSInteger timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟内";
	} else if (timeInterval < 3600) {//1小时内
        return [NSString stringWithFormat:@"%ld分钟前", (long)(timeInterval / 60)];
	} else if (timeInterval < 21600) {//6小时内
        return [NSString stringWithFormat:@"%ld小时前", (long)timeInterval / 3600];
	} else if ([theDay isEqualToString:currentDay]) {//当天
		[dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate:self]];
	} else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else {//以前
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:self];
	}
}

- (double)xle_timeIntervalSince1970InMilliSecond {
    double ret;
    ret = [self timeIntervalSince1970] * 1000;
    
    return ret;
}

+ (NSDate *)xle_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

+ (NSString *)xle_formattedTimeFromTimeInterval:(long long)time{
    return [[NSDate xle_dateWithTimeIntervalInMilliSecondSince1970:time] xle_formattedTime];
}

#pragma mark string from date
- (NSString *)xle_dayString
{
    NSDateFormatter *dayDateFormatter = [NSDateFormatter xle_dateFormatter];
    [dayDateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dayDateFormatter stringFromDate:self];
}

- (NSString *)xle_monthString
{
    NSDateFormatter *dayDateFormatter = [NSDateFormatter xle_dateFormatter];
    [dayDateFormatter setDateFormat:@"yyyy-MM"];
    return [dayDateFormatter stringFromDate:self];
}

#pragma mark Relative Dates

+ (NSDate *) xle_dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] xle_dateByAddingDays:days];
}

+ (NSDate *) xle_dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] xle_dateBySubtractingDays:days];
}

+ (NSDate *) xle_dateTomorrow
{
	return [NSDate xle_dateWithDaysFromNow:1];
}

//上一个月
- (NSDate *) xle_lastMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:-1];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

//下一个月
- (NSDate *)xle_nextMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

+ (NSDate *) xle_dateYesterday
{
	return [NSDate xle_dateWithDaysBeforeNow:1];
}

- (NSDate *)xle_nextDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * 24 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)xle_backDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] - D_HOUR * 24 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) xle_dateWithHoursFromNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *) xle_dateWithHoursBeforeNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *) xle_dateWithMinutesFromNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *) xle_dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

#pragma mark Comparing Dates

- (BOOL) xle_isEqualToDateIgnoringTime: (NSDate *) aDate
{
	NSDateComponents *components1 = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:aDate];
	return ((components1.year == components2.year) &&
			(components1.month == components2.month) &&
			(components1.day == components2.day));
}

- (BOOL) xle_isToday
{
	return [self xle_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) xle_isTomorrow
{
	return [self xle_isEqualToDateIgnoringTime:[NSDate xle_dateTomorrow]];
}

- (BOOL) xle_isYesterday
{
	return [self xle_isEqualToDateIgnoringTime:[NSDate xle_dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) xle_isSameWeekAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:aDate];
	
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if (components1.week != components2.week) return NO;
	
	// Must have a time interval under 1 week. Thanks @aclark
	return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) xle_isThisWeek
{
	return [self xle_isSameWeekAsDate:[NSDate date]];
}

- (BOOL) xle_isNextWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self xle_isSameWeekAsDate:newDate];
}

- (BOOL) xle_isLastWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self xle_isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) xle_isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [XLECURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [XLECURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) xle_isThisMonth
{
    return [self xle_isSameMonthAsDate:[NSDate date]];
}

- (BOOL) xle_isSameYearAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [XLECURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [XLECURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
	return (components1.year == components2.year);
}

- (BOOL) xle_isThisYear
{
    // Thanks, baspellis
	return [self xle_isSameYearAsDate:[NSDate date]];
}

- (BOOL) xle_isNextYear
{
	NSDateComponents *components1 = [XLECURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [XLECURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return (components1.year == (components2.year + 1));
}

- (BOOL) xle_isLastYear
{
	NSDateComponents *components1 = [XLECURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [XLECURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return (components1.year == (components2.year - 1));
}

- (BOOL) xle_isEarlierThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) xle_isLaterThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) xle_isInFuture
{
    return ([self xle_isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) xle_isInPast
{
    return ([self xle_isEarlierThanDate:[NSDate date]]);
}


#pragma mark Roles
- (BOOL) xle_isTypicallyWeekend
{
    NSDateComponents *components = [XLECURRENT_CALENDAR components:NSWeekdayCalendarUnit fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) xle_isTypicallyWorkday
{
    return ![self xle_isTypicallyWeekend];
}

#pragma mark Adjusting Dates

- (NSDate *) xle_dateByAddingDays: (NSInteger) dDays
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *) xle_dateBySubtractingDays: (NSInteger) dDays
{
	return [self xle_dateByAddingDays: (dDays * -1)];
}

- (NSDate *) xle_dateByAddingHours: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *) xle_dateBySubtractingHours: (NSInteger) dHours
{
	return [self xle_dateByAddingHours: (dHours * -1)];
}

- (NSDate *) xle_dateByAddingMinutes: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *) xle_dateBySubtractingMinutes: (NSInteger) dMinutes
{
	return [self xle_dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *) xle_dateAtStartOfDay
{
	NSDateComponents *components = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [XLECURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *) xle_componentsWithOffsetFromDate: (NSDate *) aDate
{
	NSDateComponents *dTime = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger) xle_minutesAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) xle_minutesBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) xle_hoursAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) xle_hoursBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) xle_daysAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_DAY);
}

- (NSInteger) xle_daysBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)xle_distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark 日期的开始~结束 （月，天，年，星期）
- (NSDate *)xle_beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)xle_endOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self xle_beginningOfDay] options:0] dateByAddingTimeInterval:-1];
}

- (NSDate *)xle_beginningOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    NSUInteger offset = ([components weekday] == [calendar firstWeekday]) ? 6 : [components weekday] - 2;
    [components setDay:[components day] - offset];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)xle_endOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeek:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self xle_beginningOfWeek] options:0] dateByAddingTimeInterval:-1];
}

- (NSDate *)xle_beginningOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)xle_endOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self xle_beginningOfMonth] options:0] dateByAddingTimeInterval:-1];
}

#pragma mark Decomposing Dates

- (NSInteger) xle_nearestHour
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [XLECURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
	return components.hour;
}

- (NSInteger) xle_hour
{
	NSDateComponents *components = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	return components.hour;
}

- (NSInteger) xle_minute
{
	NSDateComponents *components = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	return components.minute;
}

- (NSInteger) xle_seconds
{
	NSDateComponents *components = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	return components.second;
}

- (NSInteger) xle_day
{
	NSDateComponents *components = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	return components.day;
}

- (NSInteger) xle_month
{
	NSDateComponents *components = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	return components.month;
}

- (NSInteger) xle_week
{
	NSDateComponents *components = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	return components.week;
}

- (NSInteger) xle_weekday
{
	NSDateComponents *components = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	return components.weekday;
}

- (NSInteger) xle_nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	return components.weekdayOrdinal;
}

- (NSInteger) xle_year
{
	NSDateComponents *components = [XLECURRENT_CALENDAR components:XLEDATE_COMPONENTS fromDate:self];
	return components.year;
}

@end
