//
//  UIBarButtonItem+ZLX.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "UIBarButtonItem+ZLX.h"
#import "UIView+ZLX.h"
@implementation UIBarButtonItem (ZLX)
+ (UIBarButtonItem *) initWithImage:(NSString *)Image HeightImage:(NSString *)HeightImage target:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:HeightImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *content = [[UIView alloc] initWithFrame:button.bounds];
    [content addSubview:button];
    return [[self alloc] initWithCustomView:content];
}
+ (instancetype) BackItemWithImage:(NSString *)Image HeightImage:(NSString *)HeightImage target:(id)target action:(SEL)action title:(NSString *)title{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:HeightImage] forState:UIControlStateHighlighted];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button sizeToFit];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
