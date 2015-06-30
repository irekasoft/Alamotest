//
//  AppDelegate.m
//  Alarms
//
//  Created by Hijazi on 29/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//
#import "DBConnection.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // New for iOS 8 - Register the notifications
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    if ([launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey]){
        isJustOpened = YES;
        localNotification = [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
        
    }
    
    
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"%s", __PRETTY_FUNCTION__);
    application.applicationIconBadgeNumber = 0;
    
    
    if (isJustOpened==YES && localNotification) {
        
        [self openAlarmAlert];
        isJustOpened = NO;
        
    }
    
}


// before trigger open alarm alert
// we need to have userinfo first

- (void)openAlarmAlert{
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    

    
    if (!alarmAlertVC){
        alarmAlertVC = [storyboard instantiateViewControllerWithIdentifier:@"AlarmAlertVC"];
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alarmAlertVC animated:YES completion:^{
            alarmAlertVC = nil;
        }];
       
    }
    
    
    UILocalNotification *notification = [NotificationManager notificationFromAlarmID:localNotification.userInfo[@"alarmID"]];
    
    // for repeating alarm we have to reschedule on the next week too!
    BOOL isRepeating = [notification.userInfo[@"isRepeating"] boolValue];
    if (isRepeating) {
        notification.fireDate = [NotificationManager dateForNextWeek:notification.fireDate];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    
    // for all notification that showed up, why must we kept you
    // you are cancelled, thanks for reminding.
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
 
    
    // opened from clicking banner
    // or from notification center
    // or from list
    // when open a notfication we can just stop it. because it was setted every single minute

    
    localNotification = notification;
    [self openAlarmAlert];
    // reschedule back?

//  [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceivedLocalNotification" object:notification userInfo:@{@"UILocalNotification":notification}];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}



- (void)applicationWillTerminate:(UIApplication *)application {

    [[DBConnection sharedInstance] saveContext];
}

#pragma mark - Split view


- (void)applicationDidEnterBackground:(UIApplication *)application{
    
    // this code will make the alarm works even when the
    //    app is silent
    
    NSLog(@"enter bg");
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error: nil];
 
    UInt32 sessionCategory = kAudioSessionCategory_AmbientSound;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
    
}


@end
