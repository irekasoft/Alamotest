//
//  AlarmAlertVC.h
//  Alarms
//
//  Created by Hijazi on 30/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface AlarmAlertVC : UIViewController <AVAudioPlayerDelegate>{
    
    NSDictionary *userInfo;
    
    AVAudioPlayer *player;
    MPMediaQuery *everything;

    SystemSoundID mysound;
    
    NSTimer *vibrateTimer;
    
}

@property (strong) UILocalNotification *notification;

@end
