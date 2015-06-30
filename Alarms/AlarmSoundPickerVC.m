//
//  AlarmSoundPickerVC.m
//  Alarms
//
//  Created by Hijazi on 30/6/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "AlarmSoundPickerVC.h"

@interface AlarmSoundPickerVC ()

@end

@implementation AlarmSoundPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"CHOOSE_ALARM", nil);
    self.headerTitles = @[NSLocalizedString(@"TUNES_FROM_APP", nil),
                          NSLocalizedString(@"GET_FROM_ITUNES_LIBRARY", nil)];
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    
}

- (NSArray*)alarmSounds{
    
    if(!_alarmSounds){
        
        _alarmSounds = @[@[@"Alarm",@"Alarm",@"caf"],
                         @[@"Guitar",@"guitar",@"caf"],
                         @[@"Ring",@"ring",@"caf"],
                         @[@"Trumpet",@"trumpet",@"aif"],
                         @[@"Cuckoo",@"cuckoosong",@"aif"],
                         @[@"Beep",@"alarm beep",@"aif"]
                         ];
        
    }
    
    return _alarmSounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    NSInteger result;
    if (section == 0) {
        result =  [self.alarmSounds count];
    } else if(section == 1){
        result = 1;
        
    }
    
    return result;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.headerTitles[section];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.alarmSounds[indexPath.row][0];
        
        if (self.selectedIndexPath.row == indexPath.row && !isTypeMusic) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
    }else if (indexPath.section == 1){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (self.currentSong){
            cell.textLabel.text = self.currentSong;
        }else{
            cell.textLabel.text = NSLocalizedString(@"CHOOSE", nil);
        }
        
        
        
        
        if (isTypeMusic) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

#pragma mark delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView reloadData];
    
    
    if (indexPath.section == 0) {
        if (!(self.selectedIndexPath.row == indexPath.row))
        {
            
//            [self playAlarmAudioSessionWithFilename:self.alarmSounds[indexPath.row][1] ext:self.alarmSounds[indexPath.row][2]];
            
        } else {
            
            if ([player isPlaying]) {
                [player stop];
            }else{
//                [self playAlarmAudioSessionWithFilename:self.alarmSounds[indexPath.row][1] ext:self.alarmSounds[indexPath.row][2]];
            }
            
        }
        
        
        self.selectedIndexPath = indexPath;
//        [DEFAULTS setObject:kAlarmTypeSound forKey:kAlarmType];
//        [DEFAULTS setObject:self.alarmSounds[indexPath.row] forKey:kAlarmTypeSoundInfoArray];
//        [DEFAULTS setObject:@(indexPath.row) forKey:kAlarmTypeSoundNumber];
//        [DEFAULTS synchronize];
        isTypeMusic = NO;
        
        // select the choose the music
    } else if (indexPath.section == 1){
        
        if (self.currentSong){
            
            // todo: use UIAlertControllerStyleActionSheet uialertcontroller
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"CHOOSE EXISTING OR NEW" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:self.currentSong style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self pickCurrentSong];
            }];
            [ac addAction:action];
            action = [UIAlertAction actionWithTitle:NSLocalizedString(@"CHOOSE_OTHER_SONG",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self pickSong];
            }];
            [ac addAction:action];
            
            action = [UIAlertAction actionWithTitle:NSLocalizedString(@"CANCEL",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            [ac addAction:action];
            
            [self presentViewController:ac animated:YES completion:nil];
            
            UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            [as addButtonWithTitle:self.currentSong];
            [as addButtonWithTitle:NSLocalizedString(@"CHOOSE_OTHER_SONG",nil)];
            [as addButtonWithTitle:NSLocalizedString(@"CANCEL",nil)];
            
            as.cancelButtonIndex = as.numberOfButtons-1;
            as.actionSheetStyle = UIBarStyleBlackTranslucent;

            
//            as.tapBlock = ^(UIActionSheet *actionSheet, NSInteger buttonIndex){
//                
//                if (buttonIndex == 0) {
//                    // todo: pick current song
//                    [self pickCurrentSong];
//                } else if (buttonIndex == 1){
//                    
//                    [self pickSong];
//                }
//                
//            };
            
            [as showInView:self.view];
            
        } else { // don't have current song
            
            [self pickSong];
        }
    }
    
}
- (void)pickSong
{
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
    mediaPicker.showsCloudItems = NO;
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = NO;
    
    [self.parentViewController presentViewController:mediaPicker animated:YES completion:nil];
}

#pragma mark - delegate (Media Picker)

- (void) mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems: (MPMediaItemCollection *)mediaItemCollection
{
    MPMediaItem *media = [mediaItemCollection.items lastObject]; // only one item select
    NSString *titleString = [media valueForProperty:MPMediaItemPropertyTitle];
    NSURL *assetURL = [media valueForProperty:MPMediaItemPropertyAssetURL];
    AVURLAsset  *songAsset  = [AVURLAsset URLAssetWithURL:assetURL options:nil];
    
    // so i have to save it
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:songAsset
                                                                      presetName: AVAssetExportPresetAppleM4A];
    exporter.outputFileType = AVFileTypeAppleM4A;
    
    NSString *exportFile = [self exportFile];
    
    NSURL *exportURL = [NSURL fileURLWithPath:exportFile];
    exporter.outputURL = exportURL;
    
    // delete first if exist
    NSError *error;
    if ([[NSFileManager defaultManager] isDeletableFileAtPath:exportFile]) {
        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:exportFile error:&error];
        if (!success) {
            NSLog(@"Error removing file at path: %@", error.localizedDescription);
            

            UIAlertController *sheet = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ERROR", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            [sheet addAction:action];
            
            [self presentViewController:sheet animated:YES completion:nil];
            
        }
    }
    
    // do the export
    // (completion handler block omitted)
    [exporter exportAsynchronouslyWithCompletionHandler:
     ^{
         //       NSData *data = [NSData dataWithContentsOfFile:exportFile];
         
         NSLog(@"exported %@",exportFile);
         
         [[AVAudioSession sharedInstance]
          setCategory:AVAudioSessionCategoryPlayback error:nil];
         self.currentSong = titleString;
         
         BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:exportFile];
         NSLog(@"fileExists %d", fileExists);
         
//         [DEFAULTS setObject:kAlarmTypeMusic forKey:kAlarmType];
//         [DEFAULTS setObject:exportFile forKey:kAlarmTypeMusicFilePath];
//         [DEFAULTS setObject:titleString forKey:kAlarmTypeMusicName];
//         [DEFAULTS synchronize];
         isTypeMusic = YES;
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
             UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
             cell.accessoryType = UITableViewCellAccessoryNone;
             cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
             cell.accessoryType = UITableViewCellAccessoryCheckmark;
             
             NSURL *url = [NSURL fileURLWithPath:exportFile];
             player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
             player.delegate = self;
             [player performSelector:@selector(play) withObject:nil afterDelay:.5f];
         });
     }];
    
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
}


- (NSString *)myDocumentsDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark song picker

- (void)pickCurrentSong{
    [[AVAudioSession sharedInstance]
     setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[self exportFile]];
    NSLog(@"fileExists %d", fileExists);
    
//    [DEFAULTS setObject:kAlarmTypeMusic forKey:kAlarmType];
//    [DEFAULTS setObject:[self exportFile] forKey:kAlarmTypeMusicFilePath];
//    [DEFAULTS setObject:self.currentSong forKey:kAlarmTypeMusicName];
//    [DEFAULTS synchronize];
    isTypeMusic = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        NSURL *url = [NSURL fileURLWithPath:[self exportFile]];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        player.delegate = self;
        [player performSelector:@selector(play) withObject:nil afterDelay:.5f];
    });
    
    
}

- (NSString *)exportFile{
    
    return [[self myDocumentsDirectory] stringByAppendingPathComponent:
            @"alarmFromIPod.m4a"];
    
}


@end
