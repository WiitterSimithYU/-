//
//  ZLXLoginRegisterController.m
//  真有趣
//
//  Created by Lixin Zhou on 16/9/10.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXLoginRegisterController.h"
#import "ZLXLoginView.h"
#import "XMGLoginRegisterView.h"
@interface ZLXLoginRegisterController ()
- (IBAction)QuitButton;
@property (weak, nonatomic) IBOutlet UIView *middleView;
- (IBAction)clickRegister:(UIButton *)sender;
@end
@implementation ZLXLoginRegisterController
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建登录view
//    XMGLoginRegisterView *loginView = [XMGLoginRegisterView loginView];
//    [self.middleView addSubview:loginView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)QuitButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
}
@end
