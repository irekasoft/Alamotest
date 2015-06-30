//
//  NotificationManager.m
//  Alarms
//
//  Created by Hijazi on 29/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "NotificationManager.h"

@implementation NotificationManager

+ (NSDate *)dateWithZeroSeconds:(NSDate *)date
{
    NSTimeInterval time = floor([date timeIntervalSinceReferenceDate] / 60.0) * 60.0;
    return  [NSDate dateWithTimeIntervalSinceReferenceDate:time];
}

+ (UILocalNotification *)notificationFromAlarmID:(NSString *)alarmID{
    
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    UILocalNotification *myNotif;
    
    for (UILocalNotification *notification in array){

        if ([notification.userInfo[@"alarmID"] isEqualToString:alarmID]){
            myNotif = notification;
        }
        
    }
    
    return myNotif;
}

+ (void)createLocalNotificationOn:(NSDate *)date text:(NSString *)text alarmID:(NSString *)alarmID isRepeating:(BOOL)isRepeating{
    
    
    NSDate *modifiedDate = [NotificationManager dateWithZeroSeconds:date];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification)
    {
        
        notification.fireDate = modifiedDate;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber = 1;
        notification.soundName = @"modern alarm.aif";
        notification.repeatInterval = NSCalendarUnitMinute;
        notification.alertBody = text;
        notification.userInfo = @{@"alarmID":alarmID, @"isRepeating":@(isRepeating)};
        
        // this will schedule the notification to fire at the fire date
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        // this will fire the notification right away, it will still also fire at the date we set
        //        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
    
    // we're creating a string of the date so we can log the time the notif is supposed to fire
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-yyy hh:mm"];


    NSString *notifDate = [formatter stringFromDate:date];
    NSLog(@"%s: fire time = %@", __PRETTY_FUNCTION__, notifDate);
    
}

+ (NSArray *)allNotifications{
    
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
  
    
    NSLog(@"notif %ld %@", array.count, array);
    return array;
}

+ (void)cancelAllNotifications{
    
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for (UILocalNotification *notif in array) {
        [[UIApplication sharedApplication] cancelLocalNotification:notif];
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

}

+ (instancetype)sharedInstance{
    
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
    
}



+ (int)intMonthFromDate:(NSDate *)date{
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:locale];
    [format setDateFormat:@"M"];
    
    return [[NSString stringWithFormat:@"%@",
             [format stringFromDate:date]] intValue];
    
}

+ (int)intYearFromDate:(NSDate *)date{
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:locale];
    [format setDateFormat:@"yyyy"];
    
    
    return [[NSString stringWithFormat:@"%@",
             [format stringFromDate:date]] intValue];
    
}

+ (int)intDayFromDate:(NSDate *)date{
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:locale];
    [format setDateFormat:@"d"];
    
    return [[NSString stringWithFormat:@"%@",
             [format stringFromDate:date]] intValue];
    
}

+ (NSString *)getShortDayName:(int)number{
    // Make reference at November 2010
    NSDateComponents *components = [[NSDateComponents alloc] init] ;
    
    [components setYear:2010];
    [components setMonth:11];
    [components setDay:number];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *date = [gregorian dateFromComponents:components];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"EE"];
    NSString *newDateString = [outputFormatter stringFromDate:date];
    
    
    return [newDateString substringToIndex:1];
}

+ (NSDate *)dateForNextForDate:(NSDate *)date dayInteger:(NSInteger)dayInt{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday fromDate:date];
    
    NSUInteger weekdayToday = [components weekday];
    
    NSInteger nextDayInt = 7 + dayInt;
    
    NSInteger daysToSpefiedDay = (nextDayInt - weekdayToday) % 7;
    
    NSDate *nextDay = [date dateByAddingTimeInterval:60*60*24*daysToSpefiedDay];
    return nextDay;
}

+ (NSDate *)dateForNextWeek:(NSDate *)date{
    
    NSDate *nextDay = [date dateByAddingTimeInterval:60*60*24*7];
    return nextDay;
}



@end
