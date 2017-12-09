//
//  ZLXSecondVoiceViewController.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/9.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//
#import "ZLXSecondVoiceViewController.h"
#import "ZLXSecondVoiceView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "ZLXTopicModel.h"
#import "NSString+XMGTimeExtension.h"
#import "UIImage+ZLX.h"
#import "ZLXAudioTool.h"
@interface ZLXSecondVoiceViewController ()
@property (nonatomic,weak) UIButton *ExitButton;
@property (nonatomic,weak) UIImageView *imageView;
/** 当前播放时长*/
@property (nonatomic,weak) UILabel *CurrentTimeLabel;
/** 总时长*/
@property (nonatomic,weak) UILabel *totalTimeLabel;
/** 被选中的button*/
@property (nonatomic,weak) UIButton *playOrPauseBtn;
/** 播放器*/
@property (nonatomic,strong) AVAudioPlayer *CurrentPlayer;
/** 定时器*/
@property (nonatomic,strong) NSTimer *ProgressTimer;
/** 进度条**/
@property (nonatomic,weak) UISlider *ProgressSlider;
@end
@implementation ZLXSecondVoiceViewController
- (void) viewDidLoad {
    [super viewDidLoad];
    [self setupChildView];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void) setupChildView{
    //初始化
    UIImageView *BigimageView = [[UIImageView alloc] init];
    [self.view addSubview:BigimageView];
    BigimageView.backgroundColor = [UIColor redColor];
    [BigimageView sd_setImageWithURL:[NSURL URLWithString:self.Model.large_image] placeholderImage:nil];
    [BigimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //添加毛玻璃效果
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    [toolBar setBarStyle:UIBarStyleBlack];
    [BigimageView addSubview:toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(BigimageView.mas_top);
        make.right.equalTo(BigimageView.mas_right);
        make.left.equalTo(BigimageView.mas_left);
        make.bottom.equalTo(BigimageView.mas_bottom);
    }];
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:@"Exit-Button"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"miniplayer_btn_playlist_close_b"] forState:UIControlStateHighlighted];
    self.ExitButton =button;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(exitButton) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.view.mas_top).offset(20);
        //        make.left.equalTo(self.view.mas_left).offset(20);
        //        make.right.equalTo(self.view.mas_right).offset(-20);
        //        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        //        make.width.equalTo(@100);
        //        make.height.equalTo(@100);
        //        make.centerX.equalTo(self.view.mas_centerX);
        //        make.centerY.equalTo(self.view.mas_centerY);
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(100);
        CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.7;
        CGFloat height = width;
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.Model.large_image] placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //如果图片下载失败
        if (!image) return;
        imageView.image = [image circelWithImage];
    }];
    //播放按钮
    UIButton *PlayButton = [[UIButton alloc] init];
    [self.view addSubview:PlayButton];
    [PlayButton setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
    [PlayButton setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateSelected];
    CGFloat PlayButtonW = PlayButton.currentImage.size.width;
    CGFloat PlayButtonH = PlayButton.currentImage.size.height;
    [PlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        CGFloat H = [UIScreen mainScreen].bounds.size.height * 0.7;
        make.top.equalTo(self.view.mas_top).offset(H);
        make.width.equalTo(@(PlayButtonW));
        make.height.equalTo(@(PlayButtonH));
    }];
    [PlayButton addTarget:self action:@selector(startPalyMusic:) forControlEvents:UIControlEventTouchUpInside];
    /** 进度条*/
    UISlider *ProgressSlider = [[UISlider alloc] init];
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderClick:)];
    [ProgressSlider addGestureRecognizer:Tap];
    [ProgressSlider addTarget:self action:@selector(startSlide) forControlEvents:UIControlEventTouchDown];
    [ProgressSlider addTarget:self action:@selector(endSlide) forControlEvents:UIControlEventTouchUpInside];
    [ProgressSlider addTarget:self action:@selector(sliderChange) forControlEvents:UIControlEventValueChanged];
    [ProgressSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    self.ProgressSlider = ProgressSlider;
    [self.view addSubview:ProgressSlider];
    [ProgressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        //        CGFloat sliderH =
        CGFloat sliderW = self.view.bounds.size.width;
        CGFloat H = self.view.bounds.size.height * 0.85;
        CGFloat sliderH = 20;
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(sliderW));
        make.height.equalTo(@(sliderH));
        make.top.equalTo(self.view.mas_top).offset(H);
    }];
    /** 当前播放时间*/
    UILabel *CurrentTimeLabel = [[UILabel alloc] init];
    self.CurrentTimeLabel = CurrentTimeLabel;
    CurrentTimeLabel.text  = [NSString stringWithFormat:@"%02zd:%02zd",0 / 60,0 % 60];
    //    CurrentTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",self.Model.voicetime / 60,self.Model.voicetime % 60];
    CurrentTimeLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:CurrentTimeLabel];
    //    CurrentTimeLabel.backgroundColor = [UIColor purpleColor];
    CurrentTimeLabel.font = [UIFont systemFontOfSize:18];
    //    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT);
    //    CGSize CurrentTimeLabelSize = [[NSString stringWithFormat:@"%zd",self.Model.voicetime] boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    CGFloat H = self.view.bounds.size.height * 0.9;
    [CurrentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.width.equalTo(@(70));
        make.height.equalTo(@(25));
        make.top.equalTo(self.view.mas_top).offset(H);
    }];
    /** 总时长*/
    UILabel *totalTimeLabel = [[UILabel alloc] init];
    self.totalTimeLabel = totalTimeLabel;
    [self.view addSubview:totalTimeLabel];
    totalTimeLabel.font = [UIFont systemFontOfSize:18];
    totalTimeLabel.textColor = [UIColor whiteColor];
    totalTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",self.Model.voicetime / 60,self.Model.voicetime % 60];
    [totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(10);
        make.width.equalTo(@(70));
        make.height.equalTo(@(25));
        make.top.equalTo(self.view.mas_top).offset(H);
    }];
}
- (void) startPalyMusic:(UIButton *) button{
    self.playOrPauseBtn.selected = NO;
    button.selected = YES;
    self.playOrPauseBtn = button;
    [self setupAVAudioPlayer];
}
- (void) setupAVAudioPlayer{
    AVAudioPlayer *currentPlayer = [ZLXAudioTool playMusicWithData:self.Model.voiceuri];
    //    self.CurrentPlayer.numberofLoop = -1;
    //    currentPlayer.numberOfLoops
    self.CurrentTimeLabel.text = [NSString stringWithTime:currentPlayer.currentTime];
    self.CurrentPlayer = currentPlayer;
    self.CurrentPlayer.numberOfLoops = -1;
    self.playOrPauseBtn.selected = self.CurrentPlayer.isPlaying;
    //开始播放动画
    [self startAnimation];
    //添加定时器
    [self removeProgressTimer];
    [self addProgressTimer];
}
- (void) exitButton{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.CurrentPlayer pause];
}
- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void) startAnimation{
    //创建基本动画
    CABasicAnimation *rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置基本动画属性
    rotateAnim.fromValue = @(0);
    rotateAnim.toValue = @(M_PI * 2);
    rotateAnim.repeatCount = NSIntegerMax;
    rotateAnim.duration = 15;
    //添加动画到图层上
    [self.imageView.layer addAnimation:rotateAnim forKey:nil];
}
- (void) removeProgressTimer{
    [self.ProgressTimer invalidate];
    self.ProgressTimer = nil;
}
- (void) addProgressTimer{
    [self upDataProgressInfo];
    self.ProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(upDataProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.ProgressTimer forMode:NSRunLoopCommonModes];
}
- (void) upDataProgressInfo{
    //设置当前的播放时间
    self.CurrentTimeLabel.text = [NSString stringWithTime:self.CurrentPlayer.currentTime];
    //更新进度条
    self.ProgressSlider.value = self.CurrentPlayer.currentTime / self.CurrentPlayer.duration;
}
- (void) sliderClick:(UITapGestureRecognizer *) sender{
    CGPoint point = [sender locationInView:sender.view];
    //获取点击比例
    CGFloat ratio = point.x / self.ProgressSlider.bounds.size.width;
    //改变滑块位置
    self.ProgressSlider.value = ratio;
    //改变歌曲播放的时间
    self.CurrentPlayer.currentTime = ratio * self.CurrentPlayer.duration;
}
- (void) startSlide {
    [self removeProgressTimer];
}
- (void) endSlide {
    //设置歌曲的播放时间
    self.CurrentPlayer.currentTime = self.ProgressSlider.value * self.CurrentPlayer.duration;
    //添加定时器
    [self addProgressTimer];
}
- (void) sliderChange{
    //设置当前播放的时间
    self.CurrentTimeLabel.text = [NSString stringWithTime:self.CurrentPlayer.duration * self.ProgressSlider.value];
}
- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
