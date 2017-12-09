//
//  ZLXAudioTool.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/9.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXAudioTool.h"

@implementation ZLXAudioTool
+ (AVAudioPlayer *) playMusicWithData:(NSString *)data{
    AVAudioPlayer *Player = nil;
    if(Player == nil){
        NSURL* url = [[NSURL alloc] initWithString:data];
        NSData* audioData = [NSData dataWithContentsOfURL:url];
        //将数据保存到本地指定位置
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"temp"];
        [audioData writeToFile:filePath atomically:YES];
        //准备播放
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        Player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        //        self.CurrentTimeLabel.text = [NSString ]
        //播放本地音乐
        [Player prepareToPlay];
        //播放音乐
        [Player play];
    }
    return Player;
}
@end
