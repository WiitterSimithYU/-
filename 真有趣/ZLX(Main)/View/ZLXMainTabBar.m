//
//  ZLXMainTabBar.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXMainTabBar.h"
#import "ZLXConst.h"
#import "ZLXImageViewController.h"
@interface ZLXMainTabBar ()
@property (nonatomic,weak) UIButton *plusbutton;
/** 监听tabBarButton的点击*/
@property (nonatomic,strong) UIControl *TabBarButton;

@end
@implementation ZLXMainTabBar

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *plusbutton = [[UIButton alloc] init];
        self.plusbutton = plusbutton;
        [plusbutton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusbutton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        plusbutton.bounds = CGRectMake(0, 0, plusbutton.currentBackgroundImage.size.width, plusbutton.currentBackgroundImage.size.height);
        [self addSubview:plusbutton];
        [plusbutton addTarget:self action:@selector(AddimageView) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void) AddimageView{
    ZLXImageViewController *imageView = [[ZLXImageViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imageView animated:YES completion:nil];
}
- (void) layoutSubviews{
    [super layoutSubviews];
           //加号按钮frame
    self.plusbutton.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
           //uitabbarbutton
    CGFloat buttonY = 0;
    CGFloat buttonX = 0;
    CGFloat buttonW = self.bounds.size.width / 5;
    CGFloat buttonH = self.bounds.size.height;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")])continue; {
            buttonX = index * buttonW;
//            //默认选中第一个
            if (index == 0 && self.TabBarButton == nil) {
                self.TabBarButton = button;
            }
            if (index > 1) {
                buttonX = (index + 1) * buttonW;
            }
            index ++;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
       
    }
}
- (void) ClickTabBarButton:(UIControl *) TabBarButton{

    if (self.TabBarButton == TabBarButton) {
        //发送通知，告诉外界，按钮被重复点击了
    [[NSNotificationCenter defaultCenter] postNotificationName:ZLXTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.TabBarButton = TabBarButton;
}
@end
