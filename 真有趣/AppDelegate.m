//
//  AppDelegate.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "AppDelegate.h"
#import "ZLXMainController.h"
#import "ZLXADViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "EaseMob.h"
@interface AppDelegate ()<EMChatManagerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    NSLog(@"环信SDK的沙盒路径 %@",NSHomeDirectory());
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ZLXADViewController *MainVc = [[ZLXADViewController alloc] init];
    //    MainVc.delegate = self;
    self.window.rootViewController = MainVc;
    [self.window makeKeyAndVisible];
    /** 开始监控网络环境*/
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //每次启动程序，都清除过期的图片
    //    [[SDImageCache sharedImageCache] cleanDisk];
    //registerSDKWithAppKey: 注册的AppKey，详细见下面注释。
    //apnsCertName: 推送证书名（不需要加后缀），详细见下面注释。
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"18556555027#zlx0880" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    //监听自动登录的状态,需要设置代理
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    return YES;
}
/** 监听环信自动登录的代理方法,自动登录的回调*/
- (void) didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{
    if (!error) {
        NSLog(@"自动登录成功！  %@",loginInfo);
    }else{
        NSLog(@"自动登录失败！");
    }
}
// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}
// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

@end
