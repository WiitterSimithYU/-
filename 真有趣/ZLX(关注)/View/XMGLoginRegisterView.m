//
//  XMGLoginRegisterView.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/15.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGLoginRegisterView.h"
#import "EaseMob.h"
#import "ZLXMainController.h"
#import "ZLXFocusController.h"
#import "ZLXHomeController.h"
#import "ZLXChatViewController.h"
#import "ZLXFocusController.h"
@interface XMGLoginRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *registerPhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *registerCode;

@end

@implementation XMGLoginRegisterView
+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
+ (instancetype)registerView
{
     return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.code.textColor = [UIColor whiteColor];
    self.phoneNum.textColor = [UIColor whiteColor];
    self.registerPhoneNum.textColor = [UIColor whiteColor];
    self.registerCode.textColor = [UIColor whiteColor];
    UIImage *image = _loginRegisterButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
   // 让按钮背景图片不要被拉伸
    [self.loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
}
- (IBAction)LoginButton {
    NSString *username = self.phoneNum.text;
    NSString *password = self.code.text;
    if (username.length == 0 || password.length == 0) {
        NSLog(@"请输入账号和密码");
        return;
    }
    //登录
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username password:password completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error) {
            NSLog(@"登录成功！%@",loginInfo);
            [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
//            self.window.rootViewController =  [[ZLXMainController alloc] init];
            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//            [EaseMob sharedInstance].chatManager is
//            ZLXChatViewController *ChatVC = [[ZLXChatViewController alloc] init];
//            ZLXFocusController *focusVC = [[ZLXFocusController alloc] init];
//            focusVC.view.frame = [UIScreen mainScreen].bounds;
//            ChatVC.tableView.frame = [UIScreen mainScreen].bounds;
//            [focusVC.view addSubview:ChatVC.tableView];
            
        }else{
            NSLog(@"登录失败！ %@",error);
        }
    } onQueue:dispatch_get_main_queue()];
}
- (IBAction)RegisterButton {
    NSString *username = self.registerPhoneNum.text;
    NSString *password = self.registerCode.text;
    if (username.length == 0 || password.length == 0) {
        NSLog(@"请输入账号和密码！");
        return;
    }
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:username password:password withCompletion:^(NSString *username, NSString *password, EMError *error) {
        if (!error) {
            NSLog(@"注册成功！");
        }else{
            NSLog(@"注册失败！ %@",error);
        }
    } onQueue:dispatch_get_main_queue()];
}
@end
