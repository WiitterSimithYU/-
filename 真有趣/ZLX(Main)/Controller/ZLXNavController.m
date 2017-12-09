//
//  ZLXNavController.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXNavController.h"
#import "UIBarButtonItem+ZLX.h"
@interface ZLXNavController ()<UIGestureRecognizerDelegate>

@end

@implementation ZLXNavController
+ (void) load{
    UINavigationBar *Bar = [UINavigationBar appearance];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:25];
    Bar.titleTextAttributes = dic;
    [Bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.interactivePopGestureRecognizer.delegate = self;
//    UIScreenEdgePanGestureRecognizer *edgePan = self;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
}

//控制手势什么时候触发，只有非根控制器的时候才会触发手势
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}
- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {//非根控制器
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem BackItemWithImage:@"navigationButtonReturn" HeightImage:@"navigationButtonReturnClick" target:self action:@selector(back) title:@"返回"];
    }
    [super pushViewController:viewController animated:animated];
}
- (void) back{
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
