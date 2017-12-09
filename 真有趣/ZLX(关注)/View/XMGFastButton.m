//
//  XMGFastButton.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/15.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGFastButton.h"
#import "UIView+ZLX.h"
@implementation XMGFastButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片位置
    self.imageView.y = 0;
    self.imageView.centerx = self.width * 0.5;
    
    // 设置标题位置
    self.titleLabel.y = self.height - self.titleLabel.height;
    
    // 计算文字宽度 , 设置label的宽度
    [self.titleLabel sizeToFit];
    
    self.titleLabel.centerx = self.width * 0.5;
    
}

@end
