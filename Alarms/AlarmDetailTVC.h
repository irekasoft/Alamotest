//
//  AlarmDetailTVC.h
//  Alarms
//
//  Created by Hijazi on 29/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AlarmSoundPickerVC.h"

@interface AlarmDetailTVC : UITableViewController{
    
    NSString *alarmID;
    
}

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *tf_title;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *daysButton;
@property (weak, nonatomic) IBOutlet UILabel *lbl_alarm_id;

@end
