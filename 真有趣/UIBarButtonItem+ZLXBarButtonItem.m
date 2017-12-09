//
//  UIBarButtonItem+ZLXBarButtonItem.m
//  有趣道
//
//  Created by zlx on 16/5/15.
//  Copyright © 2016年 ZLX. All rights reserved.
//

#import "UIBarButtonItem+ZLXBarButtonItem.h"

@implementation UIBarButtonItem (ZLXBarButtonItem)
+ (instancetype) initWithImage:(NSString *)Image HeightImage:(NSString *)HeightImage target:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:HeightImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}
@end
