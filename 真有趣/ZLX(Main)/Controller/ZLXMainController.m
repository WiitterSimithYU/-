//
//  ZLXMainController.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXMainController.h"
#import "ZLXNewController.h"
#import "ZLXHomeController.h"
#import "ZLXMineController.h"
#import "ZLXFocusController.h"
#import "ZLXNavController.h"
#import "UIImage+ZLX.h"
#import "ZLXMainTabBar.h"
#import "EaseMob.h"
#import "ZLXChatViewController.h"
@interface ZLXMainController ()//<UITabBarControllerDelegate>

@end

@implementation ZLXMainController
//- (instancetype) in
+ (void) initialize{
    /** 默认状态*/
    NSMutableDictionary *Mdic = [NSMutableDictionary dictionary];
    Mdic[NSForegroundColorAttributeName] = [UIColor grayColor];
    Mdic[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    /** 选中状态*/
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[NSForegroundColorAttributeName] = [UIColor colorWithRed:81/255 green:81/255 blue:81/255 alpha:1.0];
    mdic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    UITabBarItem *Item = [UITabBarItem appearance];
    [Item setTitleTextAttributes:Mdic forState:UIControlStateNormal];
    [Item setTitleTextAttributes:mdic forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVC];
//    self.delegate = self;
    [self setValue:[[ZLXMainTabBar alloc]init] forKey:@"tabBar"];
}
- (void) setupChildVC{

    /** 精华*/
    ZLXHomeController *home = [[ZLXHomeController alloc] init];
    NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Best" value:@"精华" table:@"本地化"];
    [self setupChildController:home title:title image:@"user_1" selectedimage:@"user"];
    /** 新帖*/
    NSString *title1 = [[NSBundle mainBundle] localizedStringForKey:@"New" value:@"新帖" table:@"本地化"];
    ZLXNewController *new = [[ZLXNewController alloc] init];
    [self setupChildController:new title:title1 image:@"-time" selectedimage:@"-time-1"];
    /** 关注*/
    if ([[EaseMob sharedInstance].chatManager isAutoLoginEnabled]) {
        ZLXChatViewController *chatVC = [[ZLXChatViewController alloc] init];
        NSString *title2 = [[NSBundle mainBundle] localizedStringForKey:@"Focus" value:@"关注" table:@"本地化"];
        [self setupChildController:chatVC title:title2 image:@"tabBar_me" selectedimage:@"tabBar_me_1"];
    }else{
        ZLXFocusController *focus = [[ZLXFocusController alloc] init];
        NSString *title2 = [[NSBundle mainBundle] localizedStringForKey:@"Focus" value:@"关注" table:@"本地化"];
        [self setupChildController:focus title:title2 image:@"tabBar_me" selectedimage:@"tabBar_me_1"];
    }
    /** 我*/
    //    UIStoryboard *story = [UIStoryboard storyboardWithName:([ZLXMineController class]) bundle:nil];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([ZLXMineController class]) bundle:nil];
    NSString *title3 = [[NSBundle mainBundle] localizedStringForKey:@"Me" value:@"我" table:@"本地化"];
    ZLXMineController *mine = [storyboard instantiateInitialViewController];
    [self setupChildController:mine title:title3 image:@"tabBar_friendTrends" selectedimage:@"tabBar_friendTrends_1"];
}
- (void) setupChildController:(UIViewController *) vc title:(NSString *) title image:(NSString *) imageName selectedimage:(NSString *) selectedimage{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageWithRander:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageWithRander:selectedimage];
    ZLXNavController *Nav = [[ZLXNavController alloc] initWithRootViewController:vc];
    [self addChildViewController:Nav];
}
@end
