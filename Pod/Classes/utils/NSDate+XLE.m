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

@implementation NSDate (XLE)

- (BOOL)xle_isAMPM
{
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    return hasAMPM;
}

#pragma mark - 格式化
/*距离当前的时间间隔描述*/
- (NSString *)xle_intervalNowDescription
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
	if (timeInterval < XLE_MINUTE) {
        return @"1分钟内";
	} else if (timeInterval < XLE_HOUR) {
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / XLE_MINUTE];
	} else if (timeInterval < XLE_DAY) {
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / XLE_HOUR];
	} else if (timeInterval < XLE_WEEK) {//一星期内
        return [NSString stringWithFormat:@"%.f天前", timeInterval / XLE_DAY];
    } else if ([self xle_isThisYear]) {//今年内 "MM月dd日"
        return [[NSDateFormatter xle_defaultMonthDayFormatter3] stringFromDate:self];
    } else {//"yyyy-MM-dd"
        return [[NSDateFormatter xle_defaultDayDateFormatter2] stringFromDate:self];
    }
}

/*精确到分钟的日期描述*/
- (NSString *)xle_minuteDescription
{
    NSDateFormatter *dateFormatter = [NSDateFormatter xle_dateFormatterWithFormat:@"ah:mm"];
    
    if ([self xle_isToday]) {//当天
		[dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
	} else if ([self xle_isYesterday]) {//昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else if ([self xle_distanceDaysToDate:[NSDate date]] < 7) {//间隔一周内
        [dateFormatter setDateFormat:@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else {//以前
		[dateFormatter setDateFormat:@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:self];
	}
}

/**
 *  根据传入的 ampm/24 区别返回不同的时间格式化数据
 *
 *  @param isAMPM 是上下午的 YES
 *
 *  @return 返回格式化好的字符串
 */
- (NSString *)xle_formattedDateWithAMPM:(BOOL)isAMPM
{
    NSInteger timeInterval = -[self timeIntervalSinceNow];
    NSString *ret = @"";
    if (timeInterval < XLE_MINUTE) {
        ret = @"刚刚";
    } else if (timeInterval < XLE_HOUR) {//1小时内
        ret = [NSString stringWithFormat:@"%ld分钟前", (long)(timeInterval / 60)];
    }
    else
    {
        BOOL hasAMPM = isAMPM;
        NSDate *date = [[NSDate date] xle_beginOfDay]; //今天 0点时间
        NSInteger hour = [self xle_maxHoursAfterDate:date];
        NSDateFormatter *dateFormatter = nil;
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
    }
    
    return ret;
}

/*标准时间日期描述*/
-(NSString *)xle_formattedDateDescription
{
    return [self xle_formattedDateWithAMPM:[self xle_isAMPM]];
}

+ (NSString *)xle_formattedDescriptionFromTimeInterval:(long long)time{
    return [[NSDate xle_dateWithTimeIntervalInMilliSecondSince1970:time] xle_formattedDateDescription];
}

#pragma mark - 毫秒的处理
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

#pragma mark string from date
//yyyy-MM-dd
- (NSString *)xle_dayString
{
    return [[NSDateFormatter xle_defaultDayDateFormatter2] stringFromDate:self];
}

//yyyy-MM
- (NSString *)xle_monthString
{
    return [[NSDateFormatter xle_defaultMonthDateFormatter2] stringFromDate:self];
}

//HH:mm
- (NSString *)xle_timeString
{
    return [[NSDateFormatter xle_defaultTimeFormatter] stringFromDate:self];
}

//yyyy-MM-dd HH:mm:ss
- (NSString *)xle_dateString
{
    return [[NSDateFormatter xle_defaultDateFormatter] stringFromDate:self];
}

#pragma mark Relative Dates

+ (NSDate *)xle_dateWithDaysAfterNow:(NSInteger)days
{
	return [[NSDate date] dateByAddingTimeInterval:days * XLE_DAY];
}

+ (NSDate *)xle_dateWithDaysBeforeNow:(NSInteger)days
{
	return [[NSDate date] dateByAddingTimeInterval: - days * XLE_DAY];
}

+ (NSDate *)xle_dateTomorrow
{
	return [NSDate xle_dateWithDaysAfterNow:1];
}

+ (NSDate *)xle_dateYesterday
{
    return [NSDate xle_dateWithDaysBeforeNow:1];
}

//上一个月
- (NSDate *)xle_lastMonth
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

- (NSDate *)xle_nextDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + XLE_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)xle_backDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] - XLE_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)xle_dateWithHoursFromNow:(NSInteger)dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + XLE_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *)xle_dateWithHoursBeforeNow:(NSInteger)dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - XLE_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *)xle_dateWithMinutesFromNow:(NSInteger)dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + XLE_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *)xle_dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - XLE_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}


#pragma mark 日期的开始~结束 （月，天，年，星期）
- (NSDate *)xle_beginOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)xle_endOfDay {
    NSDate *beginDay = [self xle_beginOfDay];
    return [beginDay dateByAddingTimeInterval:XLE_DAY - 1];
}

- (NSDate *)xle_beginOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:self];
    
    NSUInteger offset = ([components weekday] == [calendar firstWeekday]) ? 6 : [components weekday] - 2;
    [components setDay:[components day] - offset];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)xle_endOfWeek {
    NSDate *beginWeek = [self xle_beginOfWeek];
    return [beginWeek dateByAddingTimeInterval:XLE_WEEK - 1];
}

- (NSDate *)xle_beginOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)xle_endOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self xle_beginOfMonth] options:0] dateByAddingTimeInterval:-1];
}


#pragma mark Comparing Dates

- (BOOL)xle_isSameDayAsDate:(NSDate *)aDate
{
    NSString *dayString = [self xle_dayString];
    NSString *dayString2 = [aDate xle_dayString];
	return [dayString isEqualToString:dayString2];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)xle_isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekday != components2.weekday) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < XLE_WEEK);
}

- (BOOL)xle_isSameYearAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

//
- (BOOL)xle_isSameMonthAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)xle_isToday
{
	return [self xle_isSameDayAsDate:[NSDate date]];
}

- (BOOL)xle_isTomorrow
{
	return [self xle_isSameDayAsDate:[NSDate xle_dateTomorrow]];
}

- (BOOL)xle_isYesterday
{
	return [self xle_isSameDayAsDate:[NSDate xle_dateYesterday]];
}



- (BOOL)xle_isThisWeek
{
	return [self xle_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)xle_isNextWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + XLE_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self xle_isSameWeekAsDate:newDate];
}

- (BOOL)xle_isLastWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - XLE_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self xle_isSameWeekAsDate:newDate];
}

- (BOOL)xle_isThisMonth
{
    return [self xle_isSameMonthAsDate:[NSDate date]];
}

- (BOOL)xle_isThisYear
{
    // Thanks, baspellis
	return [self xle_isSameYearAsDate:[NSDate date]];
}

- (BOOL)xle_isNextYear
{
	NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
	
	return (components1.year == (components2.year + 1));
}

- (BOOL)xle_isLastYear
{
	NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
	
	return (components1.year == (components2.year - 1));
}

#pragma mark Roles
- (BOOL)xle_isWeekend
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)xle_isWorkday
{
    return ![self xle_isWeekend];
}

#pragma mark Retrieving Intervals
- (NSInteger)xle_maxHoursAfterDate:(NSDate *)date
{
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    NSInteger hour = 0;
    NSTimeInterval hi = ti / XLE_HOUR;
    if (ti>=0) {
        hour = ceil(hi);
    }
    else
        hour = -ceil(fabs(hi));
    return hour;
}

- (NSInteger)xle_minutesAfterDate:(NSDate *)aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / XLE_MINUTE);
}

- (NSInteger)xle_minutesBeforeDate:(NSDate *)aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / XLE_MINUTE);
}

- (NSInteger)xle_hoursAfterDate:(NSDate *)aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / XLE_HOUR);
}

- (NSInteger)xle_hoursBeforeDate:(NSDate *)aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / XLE_HOUR);
}

- (NSInteger)xle_daysAfterDate:(NSDate *)aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / XLE_DAY);
}

- (NSInteger)xle_daysBeforeDate:(NSDate *)aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / XLE_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)xle_distanceDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark Decomposing Dates

- (NSInteger)xle_nearestHour
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute | NSCalendarUnitHour fromDate:self];
    NSInteger hour = components.hour;
    if (components.minute > 30) {
        hour++;
    }
	return hour;
}

- (NSInteger)xle_hour
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self];
	return components.hour;
}

- (NSInteger)xle_minute
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self];
	return components.minute;
}

- (NSInteger)xle_seconds
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self];
	return components.second;
}

- (NSInteger)xle_day
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self];
	return components.day;
}

- (NSInteger)xle_month
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
	return components.month;
}

- (NSInteger)xle_weekday
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    //TODO
	return components.weekday;
}

- (NSInteger)xle_year
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
	return components.year;
}

@end
