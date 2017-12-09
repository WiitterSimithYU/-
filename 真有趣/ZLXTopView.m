//
//  ZLXTopView.m
//  scrollview的代理方法-09
//
//  Created by Lixin Zhou on 16/8/19.
//  Copyright © 2016年 ZLX. All rights reserved.
//

#import "ZLXTopView.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
@implementation ZLXTopView
static UIWindow *window_;
+ (void) initialize{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [window_ addGestureRecognizer:tap];
}
+ (void) showWindow{
    
    window_.hidden = NO;
}
/** 监听窗口的点击*/
+ (void) click{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchTableviewInView:window];
}
//递归
+ (void) searchTableviewInView:(UIView *) superView{
    
    for (UITableView *subview in superView.subviews) {
//        if ([subview isKindOfClass:[UITableView class]]) {
//            [subview setContentOffset:CGPointMake(0, 0) animated:YES];
//        }
        CGRect newFrame = [subview.superview convertRect:subview.frame toView:nil];
        CGRect winBounds = [UIApplication sharedApplication].keyWindow.bounds;
        /** CGRectIntersectsRect(newFrame, winBounds)
         newFrame是否包含当前winBounds窗口
         */
        BOOL isShowingOnWindow = !subview.isHidden && subview.alpha > 0.01 && CGRectIntersectsRect(newFrame, winBounds);
        
        /** 如果是tableview，就滚动到顶部*/
        if ([subview isKindOfClass:[UITableView class]] && isShowingOnWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        [self searchTableviewInView:subview];
    }
   
    //继续查找
}

@end
