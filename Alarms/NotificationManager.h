//
//  NotificationManager.h
//  Alarms
//
//  Created by Hijazi on 29/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NotificationManager : NSObject

+ (NSArray *)allNotifications;

+ (UILocalNotification *)notificationFromAlarmID:(NSString *)alarmID;


+ (void)cancelAllNotifications;

+ (instancetype)sharedInstance;

+ (int)intMonthFromDate:(NSDate *)date;
+ (int)intYearFromDate:(NSDate *)date;
+ (int)intDayFromDate:(NSDate *)date;

+ (void)createLocalNotificationOn:(NSDate *)date text:(NSString *)text alarmID:(NSString *)alarmID isRepeating:(BOOL)isRepeating;

+ (NSDate *)dateForNextForDate:(NSDate *)date dayInteger:(NSInteger)dayInt;

+ (NSDate *)dateForNextWeek:(NSDate *)date;

@end
