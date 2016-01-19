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

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (XLE)

- (NSString *)xle_timeIntervalDescription;//距离当前的时间间隔描述
- (NSString *)xle_minuteDescription;/*精确到分钟的日期描述*/
/**
 *  根据传入的 ampm/24 区别返回不同的时间格式化数据
 *
 *  @param isAMPM 是上下午的 YES
 *
 *  @return 返回格式化好的字符串
 */
- (NSString *)xle_formattedTimeWithAMPM:(BOOL)isAMPM;
- (NSString *)xle_formattedTime;
- (NSString *)xle_formattedDateDescription;//格式化日期描述
- (double)xle_timeIntervalSince1970InMilliSecond;
+ (NSDate *)xle_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;
+ (NSString *)xle_formattedTimeFromTimeInterval:(long long)time;
// Relative dates from the current date
+ (NSDate *) xle_dateTomorrow;
//上一个月
- (NSDate *) xle_lastMonth;
//下一个月
- (NSDate *)xle_nextMonth;
//下几天
- (NSDate *)xle_nextDays:(NSInteger)days;
- (NSDate *)xle_backDays:(NSInteger)days;
+ (NSDate *) xle_dateYesterday;
+ (NSDate *) xle_dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) xle_dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) xle_dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) xle_dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) xle_dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) xle_dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Comparing dates
- (BOOL) xle_isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) xle_isToday;
- (BOOL) xle_isTomorrow;
- (BOOL) xle_isYesterday;
- (BOOL) xle_isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) xle_isThisWeek;
- (BOOL) xle_isNextWeek;
- (BOOL) xle_isLastWeek;
- (BOOL) xle_isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) xle_isThisMonth;
- (BOOL) xle_isSameYearAsDate: (NSDate *) aDate;
- (BOOL) xle_isThisYear;
- (BOOL) xle_isNextYear;
- (BOOL) xle_isLastYear;
- (BOOL) xle_isEarlierThanDate: (NSDate *) aDate;
- (BOOL) xle_isLaterThanDate: (NSDate *) aDate;
- (BOOL) xle_isInFuture;
- (BOOL) xle_isInPast;

- (NSDate *)xle_beginningOfDay;
- (NSDate *)xle_endOfDay;
- (NSDate *)xle_beginningOfWeek;
- (NSDate *)xle_endOfWeek;
- (NSDate *)xle_beginningOfMonth;
- (NSDate *)xle_endOfMonth;

// string from date
- (NSString *)xle_dayString;
- (NSString *)xle_monthString;

// Date roles
- (BOOL) xle_isTypicallyWorkday;
- (BOOL) xle_isTypicallyWeekend;

// Adjusting dates
- (NSDate *) xle_dateByAddingDays: (NSInteger) dDays;
- (NSDate *) xle_dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) xle_dateByAddingHours: (NSInteger) dHours;
- (NSDate *) xle_dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) xle_dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) xle_dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) xle_dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) xle_minutesAfterDate: (NSDate *) aDate;
- (NSInteger) xle_minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) xle_hoursAfterDate: (NSDate *) aDate;
- (NSInteger) xle_hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) xle_daysAfterDate: (NSDate *) aDate;
- (NSInteger) xle_daysBeforeDate: (NSDate *) aDate;
- (NSInteger)xle_distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger xle_nearestHour;
@property (readonly) NSInteger xle_hour;
@property (readonly) NSInteger xle_minute;
@property (readonly) NSInteger xle_seconds;
@property (readonly) NSInteger xle_day;
@property (readonly) NSInteger xle_month;
@property (readonly) NSInteger xle_week;
@property (readonly) NSInteger xle_weekday;
@property (readonly) NSInteger xle_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger xle_year;

@end
