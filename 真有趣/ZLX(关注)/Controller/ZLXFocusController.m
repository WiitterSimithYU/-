//
//  ZLXFocusController.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//
#import "ZLXFocusController.h"
#import "UIBarButtonItem+ZLX.h"
#import "ZLXLoginRegisterController.h"
#import "XMGLoginRegisterViewController.h"
//#import "EaseMob.h"
//#import "ZLXChatViewController.h"
@interface ZLXFocusController ()
@end
@implementation ZLXFocusController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithImage:@"mainCellShare" HeightImage:@"mainCellShareClick" target:self action:@selector(clickbutton)];
//    if ([[EaseMob sharedInstance].chatManager isAutoLoginEnabled]) {
//        ZLXChatViewController *ChatVC = [[ZLXChatViewController alloc] init];
//        ChatVC.tableView.frame = self.view.bounds;
//        [self.view addSubview:ChatVC.tableView];
//    }
    
}
- (void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
- (void) clickbutton{
    NSLog(@"点击了！");
}
- (IBAction)ClickBtn:(UIButton *)sender {
    XMGLoginRegisterViewController *LoginRegister = [[XMGLoginRegisterViewController alloc] init];
    LoginRegister.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:LoginRegister animated:YES completion:nil];
}
@end
