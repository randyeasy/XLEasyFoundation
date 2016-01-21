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

#define XLE_MINUTE	60
#define XLE_HOUR	3600
#define XLE_DAY		86400
#define XLE_WEEK	604800

@interface NSDate (XLE)

- (NSString *)xle_intervalNowDescription;
- (NSString *)xle_minuteDescription;
- (NSString *)xle_formattedDateWithAMPM:(BOOL)isAMPM;
- (NSString *)xle_formattedDateDescription;
+ (NSString *)xle_formattedDescriptionFromTimeInterval:(long long)time;

- (double)xle_timeIntervalSince1970InMilliSecond;
+ (NSDate *)xle_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

- (NSString *)xle_dayString;
- (NSString *)xle_monthString;
- (NSString *)xle_timeString;
- (NSString *)xle_dateString;

+ (NSDate *)xle_dateWithDaysAfterNow:(NSInteger) days;
+ (NSDate *)xle_dateWithDaysBeforeNow:(NSInteger) days;
+ (NSDate *)xle_dateTomorrow;
+ (NSDate *)xle_dateYesterday;
- (NSDate *)xle_lastMonth;
- (NSDate *)xle_nextMonth;
- (NSDate *)xle_nextDays:(NSInteger)days;
- (NSDate *)xle_backDays:(NSInteger)days;
+ (NSDate *)xle_dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)xle_dateWithHoursBeforeNow:(NSInteger)dHours;

- (NSDate *)xle_beginOfDay;
- (NSDate *)xle_endOfDay;
- (NSDate *)xle_beginOfWeek;
- (NSDate *)xle_endOfWeek;
- (NSDate *)xle_beginOfMonth;
- (NSDate *)xle_endOfMonth;

- (BOOL)xle_isAMPM;
- (BOOL)xle_isSameDayAsDate:(NSDate *)aDate;
- (BOOL)xle_isSameWeekAsDate: (NSDate *) aDate;
- (BOOL)xle_isSameYearAsDate:(NSDate *)aDate;
- (BOOL)xle_isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)xle_isToday;
- (BOOL)xle_isTomorrow;
- (BOOL)xle_isYesterday;
- (BOOL)xle_isThisWeek;
- (BOOL)xle_isNextWeek;
- (BOOL)xle_isLastWeek;
- (BOOL)xle_isThisMonth;
- (BOOL)xle_isThisYear;
- (BOOL)xle_isNextYear;
- (BOOL)xle_isLastYear;
- (BOOL)xle_isWeekend;
- (BOOL)xle_isWorkday;

- (NSInteger)xle_minutesAfterDate:(NSDate *)aDate;
- (NSInteger)xle_minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)xle_hoursAfterDate:(NSDate *)aDate;
- (NSInteger)xle_hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)xle_daysAfterDate:(NSDate *)aDate;
- (NSInteger)xle_daysBeforeDate:(NSDate *)aDate;
- (NSInteger)xle_distanceDaysToDate:(NSDate *)anotherDate;

- (NSInteger)xle_nearestHour;
- (NSInteger)xle_hour;
- (NSInteger)xle_minute;
- (NSInteger)xle_seconds;
- (NSInteger)xle_day;
- (NSInteger)xle_month;
- (NSInteger)xle_weekday;
- (NSInteger)xle_year;

@end
