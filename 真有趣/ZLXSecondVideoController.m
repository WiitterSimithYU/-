//
//  ZLXSecondVideoController.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/9/29.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXSecondVideoController.h"
#import "XJAVPlayer.h"
#import "ZLXTopicModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
@interface ZLXSecondVideoController ()<XJAVPlayerDelegate,UIScrollViewDelegate>

- (IBAction)ExitButton;
@property (nonatomic,weak) XJAVPlayer *myPlayer;
@end

@implementation ZLXSecondVideoController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.myPlayer play];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myPlayer play];
    self.view.backgroundColor = [UIColor blackColor];
    // 导航栏（navigationbar）
    //    CGRect navigationFrame =self.navigationController.navigationBar.frame;
    XJAVPlayer *myPlayer = [[XJAVPlayer alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 200)];
    myPlayer.delegate = self;
    myPlayer.xjPlayerUrl = self.VideoModel.videouri;
    NSLog(@"%@",self.VideoModel.videouri);
    self.myPlayer = myPlayer;
    [self.view addSubview:self.myPlayer];
//    [myPlayer addXJPlayerAutoMovie];
}
//- (void) nextXJPlayer{
//    self.myPlayer.xjPlayerUrl = self.VideoModel.videouri;
//}
- (void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect statusFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusH = statusFrame.size.height;
    self.myPlayer.frame = CGRectMake(0, statusH, self.view.bounds.size.width, 200);
}
- (void) xjPlayerFullOrSmall:(BOOL)flag{
    if (flag) {
        self.navigationController.navigationBarHidden = YES;
        self.tabBarController.tabBar.hidden = YES;
    }else{
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
    }
    if (flag) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)ExitButton {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (!self.myPlayer.isPlay) {
        [self.myPlayer pause];
    }
    [self.myPlayer pause];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
