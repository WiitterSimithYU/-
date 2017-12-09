//
//  ViewController.m
//  02-远程视频播放(AVPlayer)
//
//  Created by apple on 15/8/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"
#import "VideoPlayView.h"
#import "FullViewController.h"
#import "ZLXTopicModel.h"
@interface ViewController () <VideoPlayViewDelegate>
@property (weak, nonatomic) VideoPlayView *playView;
@property (nonatomic, strong) FullViewController *fullVc;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupVideoPlayView];
    UIButton *button = [[UIButton alloc] init];
    [self.view addSubview:button];
    button.width = 60;
    button.height = 60;
    button.x = 0;
    button.y = self.view.height * 0.5;
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(ExitButton) forControlEvents:UIControlEventTouchUpInside];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.videoModel.videouri]];
    self.playView.playerItem = item;
}
- (void) ExitButton{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.playView sto]
}
- (void)setupVideoPlayView
{
    VideoPlayView *playView = [VideoPlayView videoPlayView];
    playView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    [self.view addSubview:playView];
    self.playView = playView;
    self.playView.delegate = self;
}

- (void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    if (isFull) {
        [self presentViewController:self.fullVc animated:YES completion:^{
            self.playView.frame = self.fullVc.view.bounds;
            [self.fullVc.view addSubview:self.playView];
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:YES completion:^{
            self.playView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
            [self.view addSubview:self.playView];
        }];
    }
}

#pragma mark - 懒加载代码
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        self.fullVc = [[FullViewController alloc] init];
    }
    
    return _fullVc;
}

@end
