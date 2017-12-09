//
//  ZLXADViewController.m
//  真有趣
//
//  Created by Lixin Zhou on 16/9/1.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXADViewController.h"
#import "ZLXADModel.h"
#import "ZLXMainController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "UIImageView+WebCache.h"
#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"
#define ZLXScreenW [UIScreen mainScreen].bounds.size.width
#define ZLXScreenH [UIScreen mainScreen].bounds.size.height
#define iphone6P (ZLXScreenH == 736)
#define iphone6 (ZLXScreenH == 667)
#define iphone5 (ZLXScreenH == 568)
#define iphone4 (ZLXScreenH == 480)
@interface ZLXADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *LaunchImage;
@property (weak, nonatomic) IBOutlet UIButton *JumpBtn;
/** 广告view*/
@property (nonatomic,weak) UIImageView *adView;
- (IBAction)ClickButton:(UIButton *)sender;
@property (nonatomic,strong) ZLXADModel *item;
/** 定时器*/
@property (nonatomic,weak) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIView *adContainView;

@end

@implementation ZLXADViewController
- (BOOL) prefersStatusBarHidden{
    return YES;
}
- (UIImageView *) adView{
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.adContainView addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        _adView = imageView;
    }
    return _adView;
}
- (IBAction)ClickButton:(UIButton *)sender {
    ZLXMainController *MainTabBarVc = [[ZLXMainController alloc] init];
//    MainTabBarVc.delegate = (id<UITabBarControllerDelegate>)[UIApplication sharedApplication].delegate;
    [UIApplication sharedApplication].keyWindow.rootViewController = MainTabBarVc;
    // 干掉定时器
    [_timer invalidate];
}
- (void) Tap{
    //跳转到相应的界面
    NSURL *url = [NSURL URLWithString:self.item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建定时器
    _timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self setupLaunchImage];
    [self loadNewData];
    // Do any additional setup after loading the view from its nib.
}
- (void) loadNewData{
    // 1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    // 3.发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        // 获取字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        // 字典转模型
        _item = [ZLXADModel mj_objectWithKeyValues:adDict];
        // 创建UIImageView展示图片，按照比例等比例填充
        CGFloat h = ZLXScreenW / _item.w * _item.h;
        if ( h < ZLXScreenH * 0.8) {
            self.adView.frame = CGRectMake(0, 0, ZLXScreenW, h);
        }else{
            self.adView.frame = CGRectMake(0, 0, ZLXScreenW, ZLXScreenH * 0.8);
        }
        // 加载广告网页
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置启动图片
- (void)setupLaunchImage
{
    if (iphone6P) { // 6p
        self.LaunchImage.image = [UIImage imageNamed:@"LaunchImage"];
    } else if (iphone6) { // 6
        self.LaunchImage.image = [UIImage imageNamed:@""];
    } else if (iphone5) { // 5
        self.LaunchImage.image = [UIImage imageNamed:@"LaunchImage"];
        
    } else if (iphone4) { // 4
        
        self.LaunchImage.image = [UIImage imageNamed:@""];
    }
}
- (void)timeChange
{
    // 倒计时
    static NSInteger i = 5;
    if (i == 1) {
        [self ClickButton:nil];
    }
    i--;
    // 设置跳转按钮文字
    [_JumpBtn setTitle:[NSString stringWithFormat:@"跳转 (%zd)",i] forState:UIControlStateNormal];
}

@end
