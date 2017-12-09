//
//  ZLXHomeController.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXHomeController.h"
#import "ZLXClassController.h"
#import "UIView+ZLX.h"
#import "UIBarButtonItem+ZLX.h"
#import "ZLXViewController.h"
@interface ZLXHomeController ()<UIScrollViewDelegate>
/** 顶部view*/
@property (nonatomic,weak) UIView *TitleView;
/** 指示器*/
@property (nonatomic,weak) UIView *indicatorView;
/** 按钮*/
@property (nonatomic,weak) UIButton *SelectedButton;
/** 内容视图*/
@property (nonatomic,weak) UIScrollView *contentView;
@end
@implementation ZLXHomeController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"精华";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupChildController];
    [self setupTitleView];
    [self setupScrollview];
    [self setupNavBar];
}
- (void) setupNavBar{
    //左边按钮
    //右边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithImage:@"mine-moon-icon" HeightImage:@"mine-moon-icon-click" target:self action:@selector(click)];
}
- (void) click{
    ZLXViewController *VC = [[ZLXViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    VC.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:VC animated:YES];
}
- (void) setupChildController{
    //全部
    ZLXClassController *allVc = [[ZLXClassController alloc] init];
    [self addChildViewController:allVc];
    allVc.type = ZLXTopicTypeAll;
    //视频
    ZLXClassController *videoVc = [[ZLXClassController alloc] init];
    [self addChildViewController:videoVc];
    videoVc.type = ZLXTopicTypeVideo;
    //声音
    ZLXClassController *voiceVc = [[ZLXClassController alloc] init];
    [self addChildViewController:voiceVc];
    voiceVc.type = ZLXTopicTypeVoice;
    //图片
    ZLXClassController *photoVc = [[ZLXClassController alloc] init];
    [self addChildViewController:photoVc];
    photoVc.type = ZLXTopicTypePicture;
    //段子
    ZLXClassController *wordVc = [[ZLXClassController alloc] init];
    [self addChildViewController:wordVc];
    wordVc.type = ZLXTopicTypeWord;
}
- (void) setupTitleView{
    /** 顶部view*/
    UIView *TitleView = [[UIView alloc] init];
    self.TitleView = TitleView;
    TitleView.x = 0;
    TitleView.y = 64;
    TitleView.width = self.view.bounds.size.width;
    TitleView.height = self.view.bounds.size.height * 0.06;
    [self.view addSubview:TitleView];
    /** 指示器*/
    UIView *indicatorView = [[UIView alloc] init];
    self.indicatorView = indicatorView;
    indicatorView.height = 2;
    indicatorView.y = TitleView.height - indicatorView.height;
    indicatorView.backgroundColor = [UIColor redColor];
    TitleView.backgroundColor = [UIColor colorWithRed:247.0 / 255 green:247.0 / 255 blue:247.0 / 255 alpha:0.90];
    NSArray *Array = @[@"全部",@"视频",@"声音",@"图片",@"笑话"];
    for (NSInteger i = 0; i < Array.count; i ++) {
        UIButton *button = [[UIButton alloc] init];
        [TitleView addSubview:button];
        button.width = TitleView.width / Array.count;
        button.height = TitleView.height;
        button.y = 0;
        button.x = i * button.width;
        [button setTitle:Array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = i;
        /** 强制布局*/
        [button layoutIfNeeded];
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        /** 默认选择第一个按钮*/
        if (i == 0) {
            button.enabled = NO;
            self.SelectedButton = button;
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerx = button.centerx;
        }
    }
    [TitleView addSubview:indicatorView];
}
/** 按钮的监听事件*/
- (void) clickBtn:(UIButton *) button{
    self.SelectedButton.enabled = YES;
    button.enabled = NO;
    self.SelectedButton = button;
    [UIView animateWithDuration:0.10  animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerx = button.centerx;
    }];
    //scrollview的偏移量
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}
- (void) setupScrollview{
    //不要自动调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    contentView.frame = self.view.bounds;
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    [self scrollViewDidEndScrollingAnimation:contentView];
}
- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController *tableviewVC = self.childViewControllers[index];
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.TitleView.frame);
    tableviewVC.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    tableviewVC.view.x = scrollView.contentOffset.x;
    tableviewVC.view.height = scrollView.height;
    tableviewVC.tableView.scrollIndicatorInsets = tableviewVC.tableView.contentInset;
    tableviewVC.view.y = 0;
    [scrollView addSubview:tableviewVC.view];
}
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self clickBtn:self.TitleView.subviews[index]];
}
@end
