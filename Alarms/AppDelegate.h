//
//  AppDelegate.h
//  Alarms
//
//  Created by Hijazi on 29/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "NotificationManager.h"
#import "AlarmAlertVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    BOOL isJustOpened;
    UILocalNotification *localNotification;
    AlarmAlertVC *alarmAlertVC;
    
}

@property (strong, nonatomic) UIWindow *window;





@end

