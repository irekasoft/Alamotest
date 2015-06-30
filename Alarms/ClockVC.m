//
//  ClockVC.m
//  Alarms
//
//  Created by Hijazi on 30/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "ClockVC.h"
#import "NotificationManager.h"

@interface ClockVC ()

@end

@implementation ClockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    notifications = [NotificationManager allNotifications];
    
    // adding the notification center
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAlarmAlert:) name:@"didReceivedLocalNotification" object:nil];
    
    UIUserNotificationSettings *grantedSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    
    NSLog(@"settigns %@", grantedSettings);

    if (grantedSettings.types == UIUserNotificationTypeNone) {
        NSLog(@"No permiossion granted");
        // prompt user to go to settings
        
    }else if (grantedSettings.types & UIUserNotificationTypeSound & UIUserNotificationTypeAlert ){
        NSLog(@"Sound and alert permissions ");
    }
    else if (grantedSettings.types  & UIUserNotificationTypeAlert){
        NSLog(@"Alert Permission Granted");
    }
}



- (IBAction)testAlarmAlert:(id)sender {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification)
    {
        
        
        notification.fireDate = [NSDate date];
        notification.applicationIconBadgeNumber = 1;
        notification.soundName = @"modern alarm.aif";
        notification.repeatInterval = NSCalendarUnitMinute;

        notification.userInfo = @{@"alarmID":@"111", @"isRepeating":@(NO)};
    }
    
    AlarmAlertVC *alarmAlertVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmAlertVC"];
    alarmAlertVC.notification = notification;
    
    [self presentViewController:alarmAlertVC animated:YES completion:nil];
    
}

- (void)showAlarmAlert:(NSNotification *)notification{
    
    
    UILocalNotification *uilocalnotif = notification.userInfo[@"UILocalNotification"];
    
    
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification Received" message:uilocalnotif.alertBody delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    
//    [alertView show];
    
    NSLog(@"show alarm alert localnotif %@", notification);
    
    AlarmAlertVC *alarmAlertVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmAlertVC"];
    alarmAlertVC.notification = uilocalnotif;
    
    [self presentViewController:alarmAlertVC animated:YES completion:nil];
    
    
}

- (IBAction)removeAllNotif:(id)sender {
    [NotificationManager cancelAllNotifications];
    [self allAlarms:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openAlarm:(id)sender {

    AlarmDetailTVC *alarmDetailTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmDetailTVC"];
    
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:alarmDetailTVC];
    
    [self presentViewController:navCon animated:YES completion:nil];
    
}
- (IBAction)allAlarms:(id)sender {
    notifications = [NotificationManager allNotifications];
    [self.tableView reloadData];
    
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [notifications count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    UILocalNotification *notif = notifications[indexPath.row];
    
    NSString *string = [NSString stringWithFormat:@"%@ - %@ (%@)",notif.alertBody, notif.fireDate.description, notif.userInfo[@"alarmID"]];
    
    cell.textLabel.text = string;
    
    return cell;
}

#pragma mark - actions

- (IBAction)appDeviceSettings:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    
}



@end
