//
//  ZLXTopicVoiceView.m
//  真有趣
//
//  Created by Lixin Zhou on 16/9/21.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXTopicVoiceView.h"
#import "ZLXTopicModel.h"
#import <AFNetworking/AFNetworking.h>
#import <AVFoundation/AVFoundation.h>
#import "ZLXVoiceController.h"
#import "ZLXSecondVoiceViewController.h"
@interface ZLXTopicVoiceView ()
- (IBAction)VoicePlay;

@property (weak, nonatomic) IBOutlet UIImageView *VoiceImage;
@property (nonatomic,weak) IBOutlet UILabel *timeLabel;
@property (nonatomic,weak) IBOutlet UILabel *playNumLabel;
/** 音乐播放器*/
@property (nonatomic,strong) AVPlayer *player;
@end
@implementation ZLXTopicVoiceView
- (void) awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (void) setVoiceModel:(ZLXTopicModel *)VoiceModel{
    _VoiceModel = VoiceModel;
    //根据网络状态加载图片
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    /** 缓存图片(大图)*/
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:VoiceModel.large_image];
    if (originImage) {//原图，下载过的
        self.VoiceImage.image = originImage;
    }else{
        if (manager.isReachableViaWiFi) {
            [self.VoiceImage sd_setImageWithURL:[NSURL URLWithString:VoiceModel.large_image] placeholderImage:nil];
            NSLog(@"WIFI");
        }else if (manager.isReachableViaWWAN){
            [self.VoiceImage sd_setImageWithURL:[NSURL URLWithString:VoiceModel.middle_image] placeholderImage:nil];
        }else{//没有可用的网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:VoiceModel.large_image];
//            self.VoiceImage.image = nil;
            if (thumbnailImage) {
                self.VoiceImage.image = thumbnailImage;
            }else{//没有下载任何图片
//                self.VoiceImage.image = [UIImage imageNamed:@"defaultUserIcon"];
                //清空循环利用的图片
                self.VoiceImage.image = nil;
            }
        }
    }
    self.timeLabel.text = [NSString stringWithFormat:@"时长%02zd:%02zd",VoiceModel.voicetime / 60,VoiceModel.voicetime % 60];
    [self setupBtnTitle:self.playNumLabel number:VoiceModel.playcount placeholder:nil];
}
- (void) setupBtnTitle:(UILabel *) Label number:(NSInteger) number placeholder:(NSString *) placeholder{
    if (number >= 10000) {
        Label.text = [NSString stringWithFormat:@"%.1f万次播放",number / 10000.0];
    }
    else{
        Label.text = [NSString stringWithFormat:@"%zd",number];
    }
}
//- ()
//+ ()
- (IBAction)VoicePlay {
//    [self.player play];
    ZLXSecondVoiceViewController *VC = [[ZLXSecondVoiceViewController alloc] init];
    VC.Model = self.VoiceModel;
    VC.hidesBottomBarWhenPushed = YES;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:VC animated:YES completion:nil];
}
//- (AVPlayer *) player{
//    if (_player == nil) {
//        _player = [AVPlayer playerWithURL:[NSURL URLWithString:self.VoiceModel.voiceuri]];
//    }
//    return _player;
//}
@end
