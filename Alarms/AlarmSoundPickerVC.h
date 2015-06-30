//
//  AlarmSoundPickerVC.h
//  Alarms
//
//  Created by Hijazi on 30/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface AlarmSoundPickerVC : UIViewController <UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate,MPMediaPickerControllerDelegate> {
    
    AVAudioPlayer *player;
    BOOL isTypeMusic;
    
}



@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSString *currentSong;
@property (strong, nonatomic) MPMusicPlayerController *musicPlayer;
@property (strong, nonatomic) NSArray *headerTitles;
@property (strong, nonatomic) NSArray *alarmSounds;

@property (strong, nonatomic) NSIndexPath *selectedIndexPath; // only used for app's music



@end
