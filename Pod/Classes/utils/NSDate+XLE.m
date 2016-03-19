
//
//  NSDate+XLE.h
//  Pods
//
//  Created by Randy on 15/12/31.
//
//

#import "NSDate+XLE.h"
#import "NSDateFormatter+XLE.h"

@implementation NSDate (XLE)

- (BOOL)XLE_isAMPM
{
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    return hasAMPM;
}

#pragma mark - 格式化
/*距离当前的时间间隔描述*/
- (NSString *)XLE_intervalNowDescription
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
    } else if ([self XLE_isThisYear]) {//今年内 "MM月dd日"
        return [[NSDateFormatter XLE_defaultMonthDayFormatter3] stringFromDate:self];
    } else {//"yyyy-MM-dd"
        return [[NSDateFormatter XLE_defaultDayDateFormatter2] stringFromDate:self];
    }
}

/*精确到分钟的日期描述*/
- (NSString *)XLE_minuteDescription
{
    NSDateFormatter *dateFormatter = [NSDateFormatter XLE_dateFormatterWithFormat:@"ah:mm"];
    
    if ([self XLE_isToday]) {//当天
		[dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
	} else if ([self XLE_isYesterday]) {//昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else if ([self XLE_distanceDaysToDate:[NSDate date]] < 7) {//间隔一周内
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
- (NSString *)XLE_formattedDateWithAMPM:(BOOL)isAMPM
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
        NSDate *date = [[NSDate date] XLE_beginOfDay]; //今天 0点时间
        NSInteger hour = [self XLE_maxHoursAfterDate:date];
        NSDateFormatter *dateFormatter = nil;
        if (!hasAMPM) { //24小时制
            if (hour <= 24 && hour >= 0) {
                dateFormatter = [NSDateFormatter XLE_dateFormatterWithFormat:@"HH:mm"];
            }else if (hour < 0 && hour >= -24) {
                dateFormatter = [NSDateFormatter XLE_dateFormatterWithFormat:@"昨天HH:mm"];
            }else {
                dateFormatter = [NSDateFormatter XLE_dateFormatterWithFormat:@"yyyy-MM-dd"];
            }
        }else {
            if (hour >= 0 && hour <= 6) {
                dateFormatter = [NSDateFormatter XLE_dateFormatterWithFormat:@"凌晨hh:mm"];
            }else if (hour > 6 && hour <=12 ) {
                dateFormatter = [NSDateFormatter XLE_dateFormatterWithFormat:@"上午hh:mm"];
            }else if (hour > 12 && hour <= 18) {
                dateFormatter = [NSDateFormatter XLE_dateFormatterWithFormat:@"下午hh:mm"];
            }else if (hour > 18 && hour <= 24) {
                dateFormatter = [NSDateFormatter XLE_dateFormatterWithFormat:@"晚上hh:mm"];
            }else if (hour < 0 && hour >= -24){
                dateFormatter = [NSDateFormatter XLE_dateFormatterWithFormat:@"昨天HH:mm"];
            }else  {
                dateFormatter = [NSDateFormatter XLE_dateFormatterWithFormat:@"yyyy-MM-dd"];
            }
        }
        ret = [dateFormatter stringFromDate:self];
    }
    
    return ret;
}

/*标准时间日期描述*/
-(NSString *)XLE_formattedDateDescription
{
    return [self XLE_formattedDateWithAMPM:[self XLE_isAMPM]];
}

+ (NSString *)XLE_formattedDescriptionFromTimeInterval:(long long)time{
    return [[NSDate XLE_dateWithTimeIntervalInMilliSecondSince1970:time] XLE_formattedDateDescription];
}

#pragma mark - 毫秒的处理
- (double)XLE_timeIntervalSince1970InMilliSecond {
    double ret;
    ret = [self timeIntervalSince1970] * 1000;
    
    return ret;
}

+ (NSDate *)XLE_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
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
- (NSString *)XLE_dayString
{
    return [[NSDateFormatter XLE_defaultDayDateFormatter2] stringFromDate:self];
}

//yyyy-MM
- (NSString *)XLE_monthString
{
    return [[NSDateFormatter XLE_defaultMonthDateFormatter2] stringFromDate:self];
}

//HH:mm
- (NSString *)XLE_timeString
{
    return [[NSDateFormatter XLE_defaultTimeFormatter] stringFromDate:self];
}

//yyyy-MM-dd HH:mm:ss
- (NSString *)XLE_dateString
{
    return [[NSDateFormatter XLE_defaultDateFormatter] stringFromDate:self];
}

#pragma mark Relative Dates

+ (NSDate *)XLE_dateWithDaysAfterNow:(NSInteger)days
{
	return [[NSDate date] dateByAddingTimeInterval:days * XLE_DAY];
}

+ (NSDate *)XLE_dateWithDaysBeforeNow:(NSInteger)days
{
	return [[NSDate date] dateByAddingTimeInterval: - days * XLE_DAY];
}

+ (NSDate *)XLE_dateTomorrow
{
	return [NSDate XLE_dateWithDaysAfterNow:1];
}

+ (NSDate *)XLE_dateYesterday
{
    return [NSDate XLE_dateWithDaysBeforeNow:1];
}

//上一个月
- (NSDate *)XLE_lastMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:-1];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

//下一个月
- (NSDate *)XLE_nextMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)XLE_nextDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + XLE_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)XLE_backDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] - XLE_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)XLE_dateWithHoursFromNow:(NSInteger)dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + XLE_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *)XLE_dateWithHoursBeforeNow:(NSInteger)dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - XLE_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *)XLE_dateWithMinutesFromNow:(NSInteger)dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + XLE_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *)XLE_dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - XLE_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}


#pragma mark 日期的开始~结束 （月，天，年，星期）
- (NSDate *)XLE_beginOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)XLE_endOfDay {
    NSDate *beginDay = [self XLE_beginOfDay];
    return [beginDay dateByAddingTimeInterval:XLE_DAY - 1];
}

- (NSDate *)XLE_beginOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:self];
    
    NSUInteger offset = ([components weekday] == [calendar firstWeekday]) ? 6 : [components weekday] - 2;
    [components setDay:[components day] - offset];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)XLE_endOfWeek {
    NSDate *beginWeek = [self XLE_beginOfWeek];
    return [beginWeek dateByAddingTimeInterval:XLE_WEEK - 1];
}

- (NSDate *)XLE_beginOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)XLE_endOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self XLE_beginOfMonth] options:0] dateByAddingTimeInterval:-1];
}


#pragma mark Comparing Dates

- (BOOL)XLE_isSameDayAsDate:(NSDate *)aDate
{
    NSString *dayString = [self XLE_dayString];
    NSString *dayString2 = [aDate XLE_dayString];
	return [dayString isEqualToString:dayString2];
}

- (BOOL)XLE_isSameWeekAsDate: (NSDate *) aDate
{
    if (fabs([self timeIntervalSinceDate:aDate]) >= XLE_WEEK) {
        return NO;
    }
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:aDate];
    
    return (components1.weekOfYear == components2.weekOfYear);
}

- (BOOL)XLE_isSameYearAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

//
- (BOOL)XLE_isSameMonthAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)XLE_isToday
{
	return [self XLE_isSameDayAsDate:[NSDate date]];
}

- (BOOL)XLE_isTomorrow
{
	return [self XLE_isSameDayAsDate:[NSDate XLE_dateTomorrow]];
}

- (BOOL)XLE_isYesterday
{
	return [self XLE_isSameDayAsDate:[NSDate XLE_dateYesterday]];
}

- (BOOL)XLE_isThisWeek
{
	return [self XLE_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)XLE_isNextWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + XLE_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self XLE_isSameWeekAsDate:newDate];
}

- (BOOL)XLE_isLastWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - XLE_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self XLE_isSameWeekAsDate:newDate];
}

- (BOOL)XLE_isThisMonth
{
    return [self XLE_isSameMonthAsDate:[NSDate date]];
}

- (BOOL)XLE_isThisYear
{
    // Thanks, baspellis
	return [self XLE_isSameYearAsDate:[NSDate date]];
}

- (BOOL)XLE_isNextYear
{
	NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
	
	return (components1.year == (components2.year + 1));
}

- (BOOL)XLE_isLastYear
{
	NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
	
	return (components1.year == (components2.year - 1));
}

#pragma mark Roles
- (BOOL)XLE_isWeekend
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)XLE_isWorkday
{
    return ![self XLE_isWeekend];
}

#pragma mark Retrieving Intervals
- (NSInteger)XLE_maxHoursAfterDate:(NSDate *)date
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

- (NSInteger)XLE_minutesAfterDate:(NSDate *)aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / XLE_MINUTE);
}

- (NSInteger)XLE_minutesBeforeDate:(NSDate *)aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / XLE_MINUTE);
}

- (NSInteger)XLE_hoursAfterDate:(NSDate *)aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / XLE_HOUR);
}

- (NSInteger)XLE_hoursBeforeDate:(NSDate *)aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / XLE_HOUR);
}

- (NSInteger)XLE_daysAfterDate:(NSDate *)aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / XLE_DAY);
}

- (NSInteger)XLE_daysBeforeDate:(NSDate *)aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / XLE_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)XLE_distanceDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark Decomposing Dates

- (NSInteger)XLE_nearestHour
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute | NSCalendarUnitHour fromDate:self];
    NSInteger hour = components.hour;
    if (components.minute > 30) {
        hour++;
    }
	return hour;
}

- (NSInteger)XLE_hour
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self];
	return components.hour;
}

- (NSInteger)XLE_minute
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self];
	return components.minute;
}

- (NSInteger)XLE_seconds
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self];
	return components.second;
}

- (NSInteger)XLE_day
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self];
	return components.day;
}

- (NSInteger)XLE_month
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
	return components.month;
}

- (NSInteger)XLE_weekday
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    NSInteger weekday = components.weekday;
    if (weekday == 1) {
        weekday = 7;
    }
    else
        weekday -= 1;
	return weekday;
}

- (NSInteger)XLE_year
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
	return components.year;
}

@end
