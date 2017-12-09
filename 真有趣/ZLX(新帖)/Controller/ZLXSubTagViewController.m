//
//  ZLXSubTagViewController.m
//  真有趣
//
//  Created by Lixin Zhou on 16/9/1.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "ZLXSubModel.h"
#import <MJExtension/MJExtension.h>
#import "ZLXSubViewCell.h"
@interface ZLXSubTagViewController ()
/** 数据*/
@property (nonatomic,strong) NSMutableArray *SubArray;
@end

@implementation ZLXSubTagViewController
- (NSMutableArray *) SubArray{
    if (_SubArray == nil) {
        _SubArray = [NSMutableArray array];
    }
    return _SubArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoadNewData];
    self.tableView.rowHeight = 75;
    
}
- (void) LoadNewData{
    //封装请求参数
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"tag_recommend";
    parameter[@"action"] = @"sub";
    parameter[@"c"] = @"topic";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       /** 字典转模型*/
        self.SubArray = [ZLXSubModel mj_objectArrayWithKeyValuesArray:responseObject];
        NSLog(@"%@",self.SubArray);
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
#pragma mark - Table view data source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.SubArray.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXSubViewCell *cell = [ZLXSubViewCell initWithTableViewCell:tableView];
    ZLXSubModel *subModel = self.SubArray[indexPath.row]; 
    cell.Model = subModel;
    return cell;
}
@end
