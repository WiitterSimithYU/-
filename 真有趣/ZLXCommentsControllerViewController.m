//
//  ZLXCommentsControllerViewController.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/9/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXCommentsControllerViewController.h"
#import "ZLXTopicModel.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import "ZLXCommentModel.h"
#import "ZLXCommentCell.h"
#import "ZLXTopicCell.h"
/** 遵守协议*/
@interface ZLXCommentsControllerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *TableView;
/** 最新评论数据*/
@property (nonatomic,strong) NSMutableArray *lastsComment;
/** 最热评论*/
@property (nonatomic,strong) NSArray *HotComment;
@end

@implementation ZLXCommentsControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupHeader];
    [self loadNewData];
    self.title = @"评论";
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
}
/** 设置头部视图*/
- (void) setupHeader{
//    UIView *cell = [UIView init]wi;
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    cell.backgroundColor = [UIColor purpleColor];
//    cell.TopicModel = self.CommentModel;
//    cell.height = self.CommentModel.cellH;
    self.TableView.tableHeaderView = cell;
//    self.TableView.rowHeight = 150;
}
/** 网络请求*/
- (void) loadNewData{
     //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.CommentModel.ID;
    params[@"hot"] = @"1";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /** 最热评论*/
        self.HotComment = [ZLXCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.lastsComment = [ZLXCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.TableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger hotCount = self.HotComment.count;
    NSInteger latesCount = self.lastsComment.count;
    if (hotCount) {
        return 2;
    }
    if (latesCount) {
        return 1;
    }
    return 0;
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSInteger hotCount = self.HotComment.count;
    //    NSInteger latesCount = self.lastsComment.count;
    if (section == 0) {
        return hotCount ? @"最热评论" : @"最新评论";
    }
    return @"最新评论";
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger hotCount = self.HotComment.count;
    NSInteger latesCount = self.lastsComment.count;
    if (section == 0) {
        return hotCount ? hotCount : latesCount;
    }
    return latesCount;
}
/** 返回section组的所有评论*/
- (NSArray *) CommentsInSection:(NSInteger) section{
    if (section == 0) {
        return self.HotComment.count ? self.HotComment : self.lastsComment;
    }
    return self.lastsComment;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXCommentCell *cell = [ZLXCommentCell initWithTableview:tableView];
    ZLXCommentModel *commet = [self commentInIdexPath:indexPath];
    cell.comment = commet;
    return cell;
}
- (ZLXCommentModel *) commentInIdexPath:(NSIndexPath *) indexpath{
    return [self CommentsInSection:indexpath.section][indexpath.row];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXCommentModel *comment = [self commentInIdexPath:indexPath];
    return comment.cellH;
}
@end
