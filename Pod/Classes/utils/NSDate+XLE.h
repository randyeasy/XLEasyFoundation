
//
//  NSDate+XLE.h
//  Pods
//
//  Created by Randy on 15/12/31.
//
//

#import <Foundation/Foundation.h>

#define XLE_MINUTE	60
#define XLE_HOUR	3600
#define XLE_DAY		86400
#define XLE_WEEK	604800

@interface NSDate (XLE)

/**
 *  1分钟内
 *  1小时内显示：几分钟前
 *  1天内显示：小时前
 *  1星期内显示：几天前
 *  今年内显示：MM月dd日
 *  去年以前显示：yyyy-MM-dd
 *
 *  @return 显示的时间字符串
 */
- (NSString *)xle_intervalNowDescription;

/**
 *  精确到分钟的描述
 *  当天显示 “ah:mm”
 *  昨天显示 “昨天 ah:mm”
 *  一周内显示 “EEEE ah:mm”
 *  一周以前显示 “yyyy-MM-dd ah:mm”
 *
 *  @return 时间字符串
 */
- (NSString *)xle_minuteDescription;

/**
 *  标准时间日期描述 主要用于聊天、列表的时间显示
 *  一分钟内显示："刚刚"
 *  一小时内显示："%ld分钟前"
 *  今天显示："HH:mm"
 *  昨天显示："昨天HH:mm"
 *  昨天之前显示："yyyy-MM-dd"
 *
 *  @return 时间字符串
 */
- (NSString *)xle_formattedDateDescription;
+ (NSString *)xle_formattedDescriptionFromTimeInterval:(long long)time;

/**
 *  获取毫秒数
 *
 *  @return 毫秒数
 */
- (double)xle_timeIntervalSince1970InMilliSecond;
/**
 *  //根据毫秒生成NSDate
 *
 *  @param timeIntervalInMilliSecond 距离1970的毫秒数
 *
 *  @return NSDate
 */
+ (NSDate *)xle_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

/**
 *  @"yyyy-MM-dd"
 *
 *  @return 天的时间格式化字符串
 */
- (NSString *)xle_dayString;
/**
 *  yyyy-MM
 *
 *  @return 月的时间格式化字符串
 */
- (NSString *)xle_monthString;
/**
 *  HH:mm
 *
 *  @return 时间格式化字符串
 */
- (NSString *)xle_timeString;
/**
 *  yyyy-MM-dd HH:mm:ss
 *
 *  @return 标准的时间格式化字符串
 */
- (NSString *)xle_dateString;

/**
 *  从现在开始的几天后
 *
 *  @param days 往后推的天数
 *
 *  @return 几天后的日期
 */
+ (NSDate *)xle_dateWithDaysAfterNow:(NSInteger) days;
/**
 *  从现在开始的几天前
 *
 *  @param days 往前推的天数
 *
 *  @return 几天前的日期
 */
+ (NSDate *)xle_dateWithDaysBeforeNow:(NSInteger) days;
/**
 *  从现在开始的几小时后
 *
 *  @param dHours 小时数
 *
 *  @return 几小时后的日期
 */
+ (NSDate *)xle_dateWithHoursFromNow:(NSInteger)dHours;
/**
 *  从现在开始的几小时前
 *
 *  @param dHours 小时数
 *
 *  @return 几小时前的日期
 */
+ (NSDate *)xle_dateWithHoursBeforeNow:(NSInteger)dHours;
/**
 *  明天的日期
 *
 *  @return 日期
 */
+ (NSDate *)xle_dateTomorrow;
/**
 *  昨天的日期
 *
 *  @return 日期
 */
+ (NSDate *)xle_dateYesterday;
/**
 *  上个月的日期
 *
 *  @return 日期
 */
- (NSDate *)xle_lastMonth;
/**
 *  下个月的日期
 *
 *  @return 日期
 */
- (NSDate *)xle_nextMonth;
/**
 *  从接受的日期几天后的
 *
 *  @param days 天数
 *
 *  @return 几天后的日期
 */
- (NSDate *)xle_nextDays:(NSInteger)days;
/**
 *  从接受的日期几天前的
 *
 *  @param days 天数
 *
 *  @return 几天前的日期
 */
- (NSDate *)xle_backDays:(NSInteger)days;

/**
 *  接受日期的开始时间，例如 2015-12-11 12:12:12 转变之后为2015-12-11 00:00:00
 *
 *  @return 日期
 */
- (NSDate *)xle_beginOfDay;
/**
 *  接受日期的结束时间，例如 2015-12-11 12:12:12 转变之后为2015-12-11 59:59:59
 *
 *  @return 日期
 */
- (NSDate *)xle_endOfDay;
- (NSDate *)xle_beginOfWeek;
- (NSDate *)xle_endOfWeek;
- (NSDate *)xle_beginOfMonth;
- (NSDate *)xle_endOfMonth;

- (BOOL)xle_isAMPM;
- (BOOL)xle_isSameDayAsDate:(NSDate *)aDate;
- (BOOL)xle_isSameWeekAsDate:(NSDate *) aDate;
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
/**
 *  是否是周末
 *
 *  @return 是周末：YES
 */
- (BOOL)xle_isWeekend;
/**
 *  是否是工作日
 *
 *  @return 是工作日：YES
 */
- (BOOL)xle_isWorkday;

- (NSInteger)xle_minutesAfterDate:(NSDate *)aDate;
- (NSInteger)xle_minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)xle_hoursAfterDate:(NSDate *)aDate;
- (NSInteger)xle_hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)xle_daysAfterDate:(NSDate *)aDate;
- (NSInteger)xle_daysBeforeDate:(NSDate *)aDate;
- (NSInteger)xle_distanceDaysToDate:(NSDate *)anotherDate;

/**
 *  离的最近的小时，05:10 返回5  05：40返回6
 */
- (NSInteger)xle_nearestHour;
- (NSInteger)xle_hour;
- (NSInteger)xle_minute;
- (NSInteger)xle_seconds;
- (NSInteger)xle_day;
- (NSInteger)xle_month;
- (NSInteger)xle_year;
/**
 *  在一星期的第几天 周一：1 周日：7
 */
- (NSInteger)xle_weekday;

@end
