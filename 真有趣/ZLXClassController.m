//
//  ZLXClassController.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXClassController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "ZLXTopView.h"
#import "ZLXConst.h"
#import "UIView+ZLX.h"
#import "ZLXTopicModel.h"
#import "SVProgressHUD.h"
#import "ZLXTopicCell.h"
#import "UIImageView+WebCache.h"
#import "ZLXCommentsControllerViewController.h"
#import "ZLXCacheTool.h"
@interface ZLXClassController ()<UIScrollViewDelegate>
//@property (nonatomic,assign) ZLXTopicType type;
/** 提示label*/
@property (nonatomic,weak) UILabel *footerLabel;
/** 刷新控件*/
@property (nonatomic,weak) UIView *footer;
/** 是否上拉刷新*/
@property (nonatomic,assign,getter=isfooterRefreshing) BOOL footerRefreshing;
/** 所有帖子数据*/
@property (nonatomic,strong) NSMutableArray<ZLXTopicModel *> *Marray;
/** 下拉刷新控件*/
@property (nonatomic,weak) UIView *header;
/** 下拉提醒label*/
@property (nonatomic,weak) UILabel *headerLabel;
/** 是否下拉刷新*/
@property (nonatomic,assign,getter=isheaderRefreshing) BOOL headerRefreshing;
/** 加载更多数据maxtime*/
@property (nonatomic,copy) NSString *maxtime;
/** AFH*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/**保存索引 */
@property (nonatomic,assign) NSInteger selectedIndex;
/** cell高度的字典*/
//@property (nonatomic,strong) NSMutableDictionary *cellHDic;
@end
@implementation ZLXClassController
/** 懒加载*/
//- (NSMutableDictionary *) cellHDic{
//    if (_cellHDic == nil) {
//        _cellHDic = [NSMutableDictionary dictionary];
//    }
//    return _cellHDic;
//}
/** 初始化*/
//- (ZLXTopicType) type{
//    if ([self isKindOfClass:[ZLXPictureViewController class]]) return ZLXTopicTypePicture;
//    if ([self isKindOfClass:[ZLXVideoViewController class]]) return ZLXTopicTypeVideo;
//    if ([self isKindOfClass:[ZLXVoiceViewController class]]) return ZLXTopicTypeVoice;
//    if ([self isKindOfClass:[ZLXWordViewController class]]) return ZLXTopicTypeWord;
//    if ([self isKindOfClass:[ZLXAllViewController class]]) return ZLXTopicTypeAll;
//    return 0;
//}
- (AFHTTPSessionManager *) manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self loadMoreData];
    //    [self headerBeginRefreshing];
    /** 模拟数据**/
    //    self.dataCount = 5;
    self.view.backgroundColor = [UIColor lightGrayColor];
    /** 监听顶部状态栏的点击事件*/
    [ZLXTopView showWindow];
    /** 遵守scrollview的代理方法*/
    self.tableView.delegate = self;
    /** 监听通知*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TabBarButtonClick) name:ZLXTabBarButtonDidRepeatClickNotification object:nil];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = ZLXMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(ZLXMargin - 35, - 128, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    /** 去掉分割线*/
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /** 下拉刷新*/
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadNewData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    /** 向上刷新*/
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(RelaodMoreData)];
}
/** 自定义刷新控件*/
//- (void) SetUpRefreshView{
//    //下拉刷新控件
//    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, -35, self.tableView.width, 35)];
//    self.header = header;
//    header.backgroundColor = [UIColor lightGrayColor];
//    //提醒label
//    UILabel *headerLabel = [[UILabel alloc] init];
//    headerLabel.frame = header.bounds;
//    self.headerLabel = headerLabel;
//    headerLabel.font = [UIFont systemFontOfSize:13];
//    [header addSubview:headerLabel];
//    headerLabel.text = @"下拉刷新";
//    headerLabel.textAlignment = NSTextAlignmentCenter;
//    [self.tableView addSubview:header];
//    //header自动进入刷新
//    //    [self loadMoreData];
//    //    [self headerBeginRefreshing];
//    //    CGFloat offsetY = -(self.tableView.contentInset.top + self.headerLabel.height);
//    //    if (self.tableView.contentOffset.y <= offsetY) {
//    //
//    //    }
//    //    [self headerBeginRefreshing];
//    //上拉刷新控件
//    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 35)];
//    self.footer = footer;
//    footer.backgroundColor = [UIColor lightGrayColor];
//    //上拉提醒label
//    UILabel *footerLabel = [[UILabel alloc] init];
//    footerLabel.frame = footer.bounds;
//    footerLabel.backgroundColor = [UIColor redColor];
//    self.footerLabel = footerLabel;
//    footerLabel.font = [UIFont systemFontOfSize:13];
//    [footer addSubview:footerLabel];
//    footerLabel.text = @"上拉刷新";
//    footerLabel.textAlignment = NSTextAlignmentCenter;
//    self.tableView.tableFooterView = footer;
//}
#pragma 实现scrollview的代理方法
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
//    //处理header
//    [self dealHeader];
//    //处理footer
//    [self dealFooter];
#warning 设置清除缓存的日期
    [SDImageCache sharedImageCache].maxCacheAge = 30 * 24 * 60 * 60;
#warning 清除缓存
    //清除内存缓存
    [[SDImageCache sharedImageCache]clearMemory];
    //清楚沙盒中所有使用SD缓存的图片
//    [[SDImageCache sharedImageCache] clearDisk];
}
/** header*/
//- (void) dealHeader{
//    if (self.isheaderRefreshing) return;//如果正在下拉刷新，就返回
//    CGFloat offsetY = -(self.tableView.contentInset.top + self.headerLabel.height);
//    if (self.tableView.contentOffset.y <= offsetY) {
//        self.headerLabel.text = @"松开刷新";
//        self.headerLabel.backgroundColor = [UIColor grayColor];
//    }else{
//        self.headerLabel.text = @"下拉刷新";
//        self.headerLabel.backgroundColor = [UIColor redColor];
//    }
//}
/** 松开手指之后调用该方法*/
//- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    //    if (self.isheaderRefreshing) return;
//    CGFloat offsetY = -(self.tableView.contentInset.top + self.headerLabel.height);
//    if (self.tableView.contentOffset.y <= offsetY) {
//        [self headerBeginRefreshing];
//    }
//}
//- (void) dealFooter{
//    if (self.tableView.contentSize.height == 0) return;//还没有任何内容时，不需要判断
//    if (self.isfooterRefreshing) return;
//    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.height - self.tableView.tableFooterView.height * 0.3;
//    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > -(self.tableView.contentInset.top))
//    {//footer完全出现，并且是往下拖拽
//        //        NSLog(@"完全出来了！%f",scrollView.contentOffset.y);
//        //进入刷新状态
////        [self footerBeginRefreshing];
//    }
//}
#pragma 监听通知，并实现通知的监听事件,此处实现点击tabBarButton刷新界面
- (void)TabBarButtonClick{
    if (self.selectedIndex == self.tabBarController.selectedIndex && self.tabBarController.selectedViewController == self.navigationController) {
        [self.tableView.mj_header beginRefreshing];
    }
    self.selectedIndex = self.tabBarController.selectedIndex;
    NSLog(@"通知发送消息成功-------//就是如此简单！！！！！！！！！！ %@",self.class );//就是如此简单！！！！！！！！！！
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.footer.hidden = (self.Marray.count == 0);
    return self.Marray.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [ZLXTopicCell initWithCell];
    }
    ZLXTopicModel *TopicModel = self.Marray[indexPath.row];
    cell.TopicModel = TopicModel;
    return cell;
}

/** 此处务必注意，一定要移除通知，否则可能会出现无法掌控的bug*/
- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark-header
/** 开始刷新*/
//- (void) headerBeginRefreshing{
//    //如果正在刷新就返回
//    if (self.isheaderRefreshing) return;
//    self.headerLabel.text = @"正在刷新数据...";
//    self.headerLabel.backgroundColor = [UIColor blueColor];
//    self.headerRefreshing = YES;
//    //    //增加内边距
//    [UIView animateWithDuration:0.25 animations:^{
//        UIEdgeInsets inset = self.tableView.contentInset;
//        inset.top += self.header.height;
//        self.tableView.contentInset = inset;
//        //修改偏移量
//        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -inset.top);
//    }];
//    [self loadNewData];
//}
/** 结束刷新*/
//- (void) headerEndRefreshing{
//    self.headerRefreshing = NO;
//    //减小内边距
//    [UIView animateWithDuration:0.25 animations:^{
//        UIEdgeInsets inset = self.tableView.contentInset;
//        inset.top -= self.header.height;
//        self.tableView.contentInset = inset;
//    }];
//}
#pragma mark-footer
/** 开始刷新*/
//- (void) footerBeginRefreshing{
//    if (self.isfooterRefreshing) return;
//    self.footerRefreshing = YES;
//    self.footerLabel.text = @"正在向服务器发送请求，请稍后...";
//    self.footerLabel.backgroundColor = [UIColor blueColor];
//    //向服务器发送请求
//    [self loadMoreData];
//}
/** 结束刷新*/
//- (void) ZLX_footerEndRefreshing{
//    self.footerRefreshing = NO;
//    self.footerLabel.text = @"上拉刷新";
//    self.footerLabel.backgroundColor = [UIColor redColor];
//}
-(NSString*)getJsonStr:(NSDictionary*)dict{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                
                                                     encoding:NSUTF8StringEncoding];
        
        return jsonString;
        
    }else{
        
        return nil;
        
    }
}
#pragma mark GetDataSoure
//- (void)getTableViewDataWithPage:(NSInteger)page {
//    NSLog(@"发送网络请求！");
//    NSString *url = [NSString stringWithFormat:URL_TABLEVIEW, page];
//    [GetTableViewData getWithUrl:url param:nil modelClass:[Item class] responseBlock:^(id dataObj, NSError *error) {
//        [_dataArray addObjectsFromArray:dataObj];
//        [_tableView reloadData];
//        [_tableView.mj_header endRefreshing];
//        [_tableView.mj_footer endRefreshing];
//    }];
//}
/** 下拉请求数据*/
- (void) reloadNewData{
    //1.取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //封装请求参数
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"a"] = @"list";
    paramters[@"c"] = @"data";
    paramters[@"type"] = @(self.type);
        [self.manager GET:ZLXBaseURL parameters:paramters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            /** 字典转模型*/
            self.Marray = [ZLXTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //存储maxtime
            self.maxtime = responseObject[@"info"][@"maxtime"];
            [self.tableView reloadData];
            //结束刷新
            [self.tableView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error.code != NSURLErrorCancelled){//并非取消任务导致的error，是其他网络问题导致的error
                [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再尝试刷新!"];
                [self.tableView.mj_header endRefreshing];
            }
        }];
    
}
/** 上拉请求更多数据*/
- (void) RelaodMoreData{
    //封装请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    [self.manager GET:ZLXBaseURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ZLX---%@",responseObject);
            NSArray *array = [ZLXTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //累加到Marray数组中
            [self.Marray addObjectsFromArray:array];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            /** 存储maxtime*/
            self.maxtime = responseObject[@"info"][@"maxtime"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) {
            [SVProgressHUD showWithStatus:@"网络繁忙，请稍后再尝试刷新!"];
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}
#warning 通过字典缓存cell的高度
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ZLXTopicModel *model = self.Marray[indexPath.row];
////    NSString *key = [NSString stringWithFormat:@"%p",model];
//    NSString *key = model.description;
//    CGFloat cellH = [self.cellHDic[key]doubleValue];
//    if (cellH == 0) {//这个模型对应的高度还没有计算。
//        //文字的Y值
//        cellH += 55;
//        //文字的高度
//        CGSize textSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * ZLXMargin, MAXFLOAT);
//        //    cellH += [model.text sizeWithFont:15 constrainedToSize:textSize lineBreakMode:<#(NSLineBreakMode)#>]
//        cellH += [model.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + ZLXMargin;
//        cellH += 35 + ZLXMargin;
//        //存储高度
//        self.cellHDic[key] = @(cellH);
//    }
//    return cellH;
//}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.Marray[indexPath.row].cellH;
}
/*** 估算高度
 性能优化*/
//- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
//}
/** 减速完毕*/
//- (void) scrollview
/** 监听cell的点击事件*/
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXCommentsControllerViewController *commentVC = [[ZLXCommentsControllerViewController alloc] init];
    /** 传递模型
     */
    ZLXTopicModel *Model = self.Marray[indexPath.row];
    commentVC.CommentModel = Model;
    commentVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentVC animated:YES];
}
@end
