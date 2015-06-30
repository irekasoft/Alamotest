//
//  AlarmAlertVC.m
//  Alarms
//
//  Created by Hijazi on 30/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "AlarmAlertVC.h"

@interface AlarmAlertVC ()

@end

@implementation AlarmAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    vibrateTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(vibrate) userInfo:nil repeats:YES];
    [vibrateTimer fire];
    
    userInfo = self.notification.userInfo;
    
    //
    
    [self playAlarmAudioSession];
    
    
    //
    
    if ([[userInfo objectForKey:@"AlarmType"] isEqualToString:@"sound"]){
        
        [self playAlarmAudioSession];
        
    }else if ([[userInfo objectForKey:@"AlarmType"] isEqualToString:@"music"]){
        
        NSString *path = [userInfo objectForKey:@"AlarmTypeMusicFilePath"];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
        NSLog(@"my path %@ %d", path, fileExists);
        
        [[AVAudioSession sharedInstance]
         setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        // probably an instance variable: AVAudioPlayer *player;
        NSArray *arrayInfo = [userInfo objectForKey:@"AlarmTypeSoundInfoArray"];
        
        NSString *filename, *ext;
        
        if (!arrayInfo) {
            
            filename = @"Alarm";
            ext = @"caf";
            
            
        }else{
            filename = arrayInfo[1];
            ext = arrayInfo[2];
            
        }
        
        NSURL *url = [NSURL fileURLWithPath:path];
        
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        player.delegate = self;
        player.volume = 1;
        
        [player performSelector:@selector(play) withObject:nil afterDelay:.1f];
        
        
    }

    
    
}

- (void)playAlarmAudioSession{
    
    [[AVAudioSession sharedInstance]
     setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // probably an instance variable: AVAudioPlayer *player;
    NSArray *arrayInfo = [userInfo objectForKey:@"AlarmTypeSoundInfoArray"];
    
    NSString *soundName = self.notification.soundName;
    
    
    NSString *filename, *ext;
    
    if (soundName) {
        NSArray *comp = [soundName componentsSeparatedByString:@"."];
        
        filename = comp[0];
        ext      = comp[1];
        
    }else{
        filename = @"modern alarm";
        ext      = @"aif";
        
    }
    
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:ext];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    if (url){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        player.delegate = self;
        
        
        [player performSelector:@selector(play) withObject:nil afterDelay:.1f];
        
    }
    
    
}

#pragma mark AVAudioPlayerDelegate (delegate)

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)_player successfully:(BOOL)flag{
    
    [player play];
    
}


- (void)vibrate
{
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)wakeUp:(id)sender {

    [player stop];
    [vibrateTimer invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (IBAction)snooze:(id)sender {
    
    //
    NSInteger minute = 5;

    NSDate *date = [self.notification.fireDate dateByAddingTimeInterval:60*minute];

    self.notification.fireDate = date;
    [[UIApplication sharedApplication] scheduleLocalNotification:self.notification];
   
    [self wakeUp:nil];
}

#pragma mark - Navigation


@end
