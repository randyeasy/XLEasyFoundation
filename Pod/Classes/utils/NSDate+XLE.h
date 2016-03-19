
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
- (NSString *)XLE_intervalNowDescription;

/**
 *  精确到分钟的描述
 *  当天显示 “ah:mm”
 *  昨天显示 “昨天 ah:mm”
 *  一周内显示 “EEEE ah:mm”
 *  一周以前显示 “yyyy-MM-dd ah:mm”
 *
 *  @return 时间字符串
 */
- (NSString *)XLE_minuteDescription;

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
- (NSString *)XLE_formattedDateDescription;
+ (NSString *)XLE_formattedDescriptionFromTimeInterval:(long long)time;

/**
 *  获取毫秒数
 *
 *  @return 毫秒数
 */
- (double)XLE_timeIntervalSince1970InMilliSecond;
/**
 *  //根据毫秒生成NSDate
 *
 *  @param timeIntervalInMilliSecond 距离1970的毫秒数
 *
 *  @return NSDate
 */
+ (NSDate *)XLE_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

/**
 *  @"yyyy-MM-dd"
 *
 *  @return 天的时间格式化字符串
 */
- (NSString *)XLE_dayString;
/**
 *  yyyy-MM
 *
 *  @return 月的时间格式化字符串
 */
- (NSString *)XLE_monthString;
/**
 *  HH:mm
 *
 *  @return 时间格式化字符串
 */
- (NSString *)XLE_timeString;
/**
 *  yyyy-MM-dd HH:mm:ss
 *
 *  @return 标准的时间格式化字符串
 */
- (NSString *)XLE_dateString;

/**
 *  从现在开始的几天后
 *
 *  @param days 往后推的天数
 *
 *  @return 几天后的日期
 */
+ (NSDate *)XLE_dateWithDaysAfterNow:(NSInteger) days;
/**
 *  从现在开始的几天前
 *
 *  @param days 往前推的天数
 *
 *  @return 几天前的日期
 */
+ (NSDate *)XLE_dateWithDaysBeforeNow:(NSInteger) days;
/**
 *  从现在开始的几小时后
 *
 *  @param dHours 小时数
 *
 *  @return 几小时后的日期
 */
+ (NSDate *)XLE_dateWithHoursFromNow:(NSInteger)dHours;
/**
 *  从现在开始的几小时前
 *
 *  @param dHours 小时数
 *
 *  @return 几小时前的日期
 */
+ (NSDate *)XLE_dateWithHoursBeforeNow:(NSInteger)dHours;
/**
 *  明天的日期
 *
 *  @return 日期
 */
+ (NSDate *)XLE_dateTomorrow;
/**
 *  昨天的日期
 *
 *  @return 日期
 */
+ (NSDate *)XLE_dateYesterday;
/**
 *  上个月的日期
 *
 *  @return 日期
 */
- (NSDate *)XLE_lastMonth;
/**
 *  下个月的日期
 *
 *  @return 日期
 */
- (NSDate *)XLE_nextMonth;
/**
 *  从接受的日期几天后的
 *
 *  @param days 天数
 *
 *  @return 几天后的日期
 */
- (NSDate *)XLE_nextDays:(NSInteger)days;
/**
 *  从接受的日期几天前的
 *
 *  @param days 天数
 *
 *  @return 几天前的日期
 */
- (NSDate *)XLE_backDays:(NSInteger)days;

/**
 *  接受日期的开始时间，例如 2015-12-11 12:12:12 转变之后为2015-12-11 00:00:00
 *
 *  @return 日期
 */
- (NSDate *)XLE_beginOfDay;
/**
 *  接受日期的结束时间，例如 2015-12-11 12:12:12 转变之后为2015-12-11 59:59:59
 *
 *  @return 日期
 */
- (NSDate *)XLE_endOfDay;
- (NSDate *)XLE_beginOfWeek;
- (NSDate *)XLE_endOfWeek;
- (NSDate *)XLE_beginOfMonth;
- (NSDate *)XLE_endOfMonth;

- (BOOL)XLE_isAMPM;
- (BOOL)XLE_isSameDayAsDate:(NSDate *)aDate;
- (BOOL)XLE_isSameWeekAsDate:(NSDate *) aDate;
- (BOOL)XLE_isSameYearAsDate:(NSDate *)aDate;
- (BOOL)XLE_isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)XLE_isToday;
- (BOOL)XLE_isTomorrow;
- (BOOL)XLE_isYesterday;
- (BOOL)XLE_isThisWeek;
- (BOOL)XLE_isNextWeek;
- (BOOL)XLE_isLastWeek;
- (BOOL)XLE_isThisMonth;
- (BOOL)XLE_isThisYear;
- (BOOL)XLE_isNextYear;
- (BOOL)XLE_isLastYear;
/**
 *  是否是周末
 *
 *  @return 是周末：YES
 */
- (BOOL)XLE_isWeekend;
/**
 *  是否是工作日
 *
 *  @return 是工作日：YES
 */
- (BOOL)XLE_isWorkday;

- (NSInteger)XLE_minutesAfterDate:(NSDate *)aDate;
- (NSInteger)XLE_minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)XLE_hoursAfterDate:(NSDate *)aDate;
- (NSInteger)XLE_hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)XLE_daysAfterDate:(NSDate *)aDate;
- (NSInteger)XLE_daysBeforeDate:(NSDate *)aDate;
- (NSInteger)XLE_distanceDaysToDate:(NSDate *)anotherDate;

/**
 *  离的最近的小时，05:10 返回5  05：40返回6
 */
- (NSInteger)XLE_nearestHour;
- (NSInteger)XLE_hour;
- (NSInteger)XLE_minute;
- (NSInteger)XLE_seconds;
- (NSInteger)XLE_day;
- (NSInteger)XLE_month;
- (NSInteger)XLE_year;
/**
 *  在一星期的第几天 周一：1 周日：7
 */
- (NSInteger)XLE_weekday;

@end
