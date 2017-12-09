//
//  ZLXAddFriendController.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/14.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXAddFriendController.h"
#import <EaseMob.h>
@interface ZLXAddFriendController ()<EMChatManagerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *friendAccount;
/** 好友名称*/
@property (nonatomic,copy) NSString *buddyUsername;
@end
@implementation ZLXAddFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加好友请求代理
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    //添加好友请求
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)addFriend {
    //添加好友
    //获取要添加好友的名字
    NSString *username = self.friendAccount.text;
    NSString *loginUsername = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
    NSString *message = [@"我是" stringByAppendingString:loginUsername];
    EMError *error = nil;
    //当前登录的用户名
    [[EaseMob sharedInstance].chatManager addBuddy:username message:message error:&error];
    if (error) {
        NSLog(@"添加好友失败 %@",error);
    }else{
        NSLog(@"添加好友成功");
    }
    //向服务器发送一个添加好友的请求
}
#pragma 监听好友添加的代理
- (void) didAcceptedByBuddy:(NSString *)username{
    NSString *message = [NSString stringWithFormat:@"%@ 同意你的请求了，现在你们已经是好友了",username];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"好友添加消息" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma 好友拒绝添加
- (void) didRejectedByBuddy:(NSString *)username{
    NSString *message = [NSString stringWithFormat:@"%@ 拒绝了你的请求",username];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"好友添加消息" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}
//- (void) didReceiveBuddyRequest:(NSString *)username message:(NSString *)message{
//    NSLog(@"是否正在调用！");
//}
- (void) didReceiveBuddyRequest:(NSString *)username message:(NSString *)message{


  //为什么这个代理方法不能调用？这是什么鬼？
    



}
- (void) dealloc{
    //移除聊天管理器的代理
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    
}
@end
