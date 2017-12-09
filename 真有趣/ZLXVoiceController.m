//
//  ZLXVoiceController.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/8.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXVoiceController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ZLX.h"
#import "ZLXTopicModel.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+XMGTimeExtension.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ZLXAudioTool.h"
#import "Masonry.h"
@interface ZLXVoiceController ()
- (IBAction)ExitButton;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
@property (weak, nonatomic) IBOutlet UILabel *CurrentTimeLabel;
- (IBAction)PlayButton;
- (IBAction)sliderClick:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UISlider *ProgressSlider;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
- (IBAction)endSlide;
@property (weak, nonatomic) IBOutlet UIImageView *PictureView;
- (IBAction)startSlide;
- (IBAction)sliderChange:(id)sender;
@property (nonatomic,strong) AVAudioPlayer *CurrentPlayer;
/** 音乐播放器*/
//@property (nonatomic,strong) AVPlayer *player;
/** 毛玻璃效果*/
@property (nonatomic,weak) UIToolbar *toolBar;
/** 进度timer*/
@property (nonatomic,strong) NSTimer *ProgressTimer;
@end

@implementation ZLXVoiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSliderFrame];
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",self.Model.voicetime / 60,self.Model.voicetime % 60];
    self.CurrentTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",0 / 60,0 % 60];
    //添加毛玻璃效果
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    [toolBar setBarStyle:UIBarStyleBlack];
    self.toolBar = toolBar;
    [self.iconView addSubview:toolBar];
//    toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.PictureView sd_setImageWithURL:[NSURL URLWithString:self.Model.large_image] placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //如果图片下载失败
                if (!image) return;
                self.PictureView.image = [image circelWithImage];
            }];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.Model.large_image] placeholderImage:[UIImage imageNamed:@"图片1"]];
    
    [self.ProgressSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
}
- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.toolBar.frame = self.iconView.bounds;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ExitButton {
    [self.CurrentPlayer pause];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//- (AVPlayer *) player{
//    if (_player == nil) {
//        _player = [AVPlayer playerWithURL:[NSURL URLWithString:self.Model.voiceuri]];
//    }
//    return _player;
//}
/** 创建动画*/
- (void) startAnimation{
 //创建基本动画
    CABasicAnimation *rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
 //设置基本动画属性
    rotateAnim.fromValue = @(0);
    rotateAnim.toValue = @(M_PI * 2);
    rotateAnim.repeatCount = NSIntegerMax;
    rotateAnim.duration = 15;
    //添加动画到图层上
    [self.PictureView.layer addAnimation:rotateAnim forKey:nil];
}
#pragma 对定时器的操作
- (void) addProgressTimer{
    [self upDataProgressInfo];
    self.ProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(upDataProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.ProgressTimer forMode:NSRunLoopCommonModes];
}
- (void) removeProgressTimer{
    [self.ProgressTimer invalidate];
    self.ProgressTimer = nil;
}
- (void) upDataProgressInfo{
     //设置当前的播放时间
    self.CurrentTimeLabel.text = [NSString stringWithTime:self.CurrentPlayer.currentTime];
    //更新进度条
    self.ProgressSlider.value = self.CurrentPlayer.currentTime / self.CurrentPlayer.duration;
}
- (void) startMusic{
    AVAudioPlayer *currentPlayer = [ZLXAudioTool playMusicWithData:self.Model.voiceuri];
    self.CurrentTimeLabel.text = [NSString stringWithTime:currentPlayer.currentTime];
    self.CurrentPlayer = currentPlayer;
    self.playOrPauseBtn.selected = self.CurrentPlayer.isPlaying;
    //开始播放动画
    [self startAnimation];
    //添加定时器
    [self removeProgressTimer];
    [self addProgressTimer];
}
- (IBAction)PlayButton {
    //播放
    [self startMusic];
    //开始动画
    [self startAnimation];
}
- (IBAction)sliderClick:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    //获取点击比例
    CGFloat ratio = point.x / self.ProgressSlider.bounds.size.width;
    //改变滑块位置
    self.ProgressSlider.value = ratio;
    //改变歌曲播放的时间
    self.CurrentPlayer.currentTime = ratio * self.CurrentPlayer.duration;
}
#pragma slider的时间处理
- (IBAction)startSlide {
    [self removeProgressTimer];
}
- (IBAction)sliderChange:(id)sender {
    //设置当前播放的时间
    self.CurrentTimeLabel.text = [NSString stringWithTime:self.CurrentPlayer.duration * self.ProgressSlider.value];
}
- (IBAction)endSlide {
    //设置歌曲的播放时间
    self.CurrentPlayer.currentTime = self.ProgressSlider.value * self.CurrentPlayer.duration;
    //添加定时器
    [self addProgressTimer];
}
- (void) setupSliderFrame {
   [self.ProgressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
       make.center.equalTo(self.centerView);
       make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width, 35));
   }];

}
@end
