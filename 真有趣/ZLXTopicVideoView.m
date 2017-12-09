//
//  ZLXTopicVideoView.m
//  真有趣
//
//  Created by Lixin Zhou on 16/9/21.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXTopicVideoView.h"
#import "UIImageView+WebCache.h"
#import "ZLXTopicModel.h"
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZLXSecondVideoController.h"
@interface ZLXTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *VideoImage;
@property (weak, nonatomic) IBOutlet UILabel *PlayNum;
- (IBAction)PlayVideo;
@property (weak, nonatomic) IBOutlet UILabel *PlayTime;

@end
@implementation ZLXTopicVideoView

- (void) awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (void) setVideoModel:(ZLXTopicModel *)VideoModel{
    _VideoModel = VideoModel;
    
    [self.VideoImage sd_setImageWithURL:[NSURL URLWithString:VideoModel.middle_image] placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]];
//    self.PlayTime.text = [NSString stringWithFormat:@"时长%02zd:%02zd",VideoModel.voicetime / 60,VideoModel.voicetime % 60];
    self.PlayTime.text = [NSString stringWithFormat:@"时长%02zd:%02zd",VideoModel.videotime / 60,VideoModel.videotime % 60];
    [self setupBtnTitle:self.PlayNum number:VideoModel.playcount placeholder:nil];
}
- (void) setupBtnTitle:(UILabel *) Label number:(NSInteger) number placeholder:(NSString *) placeholder{
    if (number >= 10000) {
        Label.text = [NSString stringWithFormat:@"%.1f万次播放",number / 10000.0];
    }
    else{
        Label.text = [NSString stringWithFormat:@"%zd",number];
    }
}
- (IBAction)PlayVideo {
    ZLXSecondVideoController *VideoVC = [[ZLXSecondVideoController alloc] init];
    VideoVC.VideoModel = self.VideoModel;
    [self.window.rootViewController presentViewController:VideoVC animated:YES completion:nil];
}
@end
