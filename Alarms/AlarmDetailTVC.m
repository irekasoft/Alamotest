//
//  AlarmDetailTVC.m
//  Alarms
//
//  Created by Hijazi on 29/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "AlarmDetailTVC.h"
#import "NotificationManager.h"

@interface AlarmDetailTVC ()

@end

@implementation AlarmDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButton;

    //
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    //
    alarmID = [NSString stringWithFormat:@"%.0f",[NSDate timeIntervalSinceReferenceDate]];
    self.lbl_alarm_id.text = alarmID;

    

}

- (void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)check:(id)sender {
    
    
    [NotificationManager allNotifications];
    
}


- (void)save{
    
   
    
    NSDate *date = self.datePicker.date;
    

    
    int count = 0;
    
    for (UIButton *button in self.daysButton){
        
        if (button.isSelected == YES) {

            NSInteger weekday = button.tag;
            NSDate *modDate = [NotificationManager dateForNextForDate:date dayInteger:weekday];
            [NotificationManager createLocalNotificationOn:modDate text:@"Alarm" alarmID:alarmID isRepeating:YES];
            count++;
        }
        
    }
    
    //
    
    // if not repeating at all, we create a special one time alarm
    if (count == 0) {
        [NotificationManager createLocalNotificationOn:date text:@"Alarm" alarmID:alarmID isRepeating:NO];        
    }

        
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    [NotificationManager allNotifications];
    
}

// for finding the day we

- (IBAction)selectDay:(UIButton *)sender {

    sender.selected = !sender.selected;
    
}

- (IBAction)pickSound:(id)sender {
    
    
    AlarmSoundPickerVC *alarmSoundPickerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmSoundPickerVC"];
    
    [self.navigationController pushViewController:alarmSoundPickerVC animated:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
