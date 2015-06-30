//
//  ClockVC.h
//  Alarms
//
//  Created by Hijazi on 30/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmDetailTVC.h"
#import "AlarmAlertVC.h"

@interface ClockVC : UIViewController <UITableViewDataSource>{
    
    NSArray *notifications;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
