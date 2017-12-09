//
//  ZLXMineController.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXMineController.h"
#import "UIBarButtonItem+ZLX.h"
#import "ZLXButtonViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "ZLXButtonModel.h"
#import "UIView+ZLX.h"
#import <SafariServices/SafariServices.h>
@interface ZLXMineController ()<UICollectionViewDataSource,UICollectionViewDelegate,SFSafariViewControllerDelegate>
@property (nonatomic,strong) NSMutableArray *Marray;
@property (nonatomic,weak) UICollectionView *FooterView;
@end

@implementation ZLXMineController
  static NSString *const ID = @"cell";
- (NSMutableArray *) Marray{
    if (_Marray == nil) {
        _Marray = [NSMutableArray array];
    }
    return _Marray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    [self loadNewData];
    [self setupFooterView];
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
}
- (void) click{
   
}
- (void) setupFooterView{
    UICollectionViewFlowLayout *FlowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat cols = 4;
    CGFloat margin = 1;
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemWH = (W - (cols - 1) * margin) / cols;
    FlowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    FlowLayout.minimumLineSpacing = margin;
    FlowLayout.minimumInteritemSpacing = margin;
    UICollectionView *FooterView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:FlowLayout];
    self.FooterView = FooterView;
    FooterView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.tableFooterView = FooterView;
    FooterView.dataSource = self;
    FooterView.delegate = self;
    FooterView.scrollEnabled = NO;
    //注册cell
    [FooterView registerNib:[UINib nibWithNibName:NSStringFromClass([ZLXButtonViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.Marray.count;
}
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZLXButtonViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    ZLXButtonModel *model = self.Marray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZLXButtonModel *model = self.Marray[indexPath.row];
    if (![model.url containsString:@"http"]) {
        return;
    }
    SFSafariViewController *safarVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:model.url]];
    safarVC.hidesBottomBarWhenPushed = YES;
    safarVC.delegate = self;
    safarVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:safarVC animated:YES];
}
- (void) safariViewControllerDidFinish:(SFSafariViewController *)controller{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) loadNewData{
    //封装请求参数
    NSMutableDictionary *Mdic = [NSMutableDictionary dictionary];
    Mdic[@"a"] = @"square";
    Mdic[@"c"] = @"topic";
    //创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:Mdic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.Marray = [ZLXButtonModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        //计算collectionview的高度
        NSInteger count = self.Marray.count;
        CGFloat cols = 4;
        NSInteger rows = (count - 1) / cols + 1;
        CGFloat margin = 1;
        CGFloat W = [UIScreen mainScreen].bounds.size.width;
        CGFloat itemWH = (W - (cols - 1) * margin) / cols;
        self.FooterView.height = rows * itemWH;
        //tableview的滚动
        self.tableView.tableFooterView = self.FooterView;
        [self.FooterView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
