//
//  ZLXChatViewController.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/12.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXChatViewController.h"
#import "ZLXFriendGroupModel.h"
#import "ZLXFriendModel.h"
#import "ZLXFriendGroupNheaderView.h"
#import "ZLXChatFriendViewController.h"
#import "ZLXFriendCell.h"
#import "EaseMob.h"
#import "UIBarButtonItem+ZLX.h"
#import "ZLXAddFriendController.h"
@interface ZLXChatViewController ()<ZLXFriendGroupNheaderViewDelegate,EMChatManagerDelegate>
/** 数据*/
@property (nonatomic,strong) NSArray *friendGroups;
@property (nonatomic,strong) NSArray *buddyList;
@end
@implementation ZLXChatViewController
- (NSArray *) friendGroups{
    if (_friendGroups == nil) {
        _friendGroups = [ZLXFriendGroupModel friendGroupsList];
    }
    return _friendGroups;
}
- (NSArray *) buddyList{
    if (_buddyList == nil) {
        _buddyList = [NSArray array];
    }
    return _buddyList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithImage:@"MainTagSubIcon" HeightImage:@"MainTagSubIconClick" target:self action:@selector(clickRecommend)];
    //添加聊天管理器的代理
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    self.tableView.sectionHeaderHeight = 44;
    //获取好友列表
    self.buddyList = [[EaseMob sharedInstance].chatManager buddyList];
    [self.tableView reloadData];
    self.title = @"好友列表";
}
- (void) clickRecommend{
    ZLXAddFriendController *addFriend = [[ZLXAddFriendController alloc] init];
    addFriend.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addFriend animated:YES];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.friendGroups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.buddyList.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EMBuddy *buddy = self.buddyList[indexPath.row];
    ZLXFriendCell *cell = [ZLXFriendCell cellWithFriendWith:tableView];
    cell.Buddy = buddy;
    return cell;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZLXFriendGroupNheaderView *headerView = [ZLXFriendGroupNheaderView headerViewWithTableView:tableView];
    headerView.delegate = self;
    headerView.tag = section;
    //设置头部视图的数据
    ZLXFriendGroupModel *friendGroup = self.friendGroups[section];
    headerView.friendGroup = friendGroup;
    return headerView;
}
//实现代理方法
- (void) headerViewDidClickedNameBtn:(ZLXFriendGroupNheaderView *)headerView{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:headerView.tag];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXChatFriendViewController *ChatView = [[ZLXChatFriendViewController alloc] init];
    ChatView.buddy = self.buddyList[indexPath.row];
    [self.tableView reloadData];
    ChatView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ChatView animated:YES];
}
#pragma 环信自动登录的代理方法
- (void) didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{
    if (!error) {//自动登录成功之后
        self.buddyList = [[EaseMob sharedInstance].chatManager buddyList];
        [self.tableView reloadData];
    }
}
#pragma 监听到好友同意的代理方法
- (void) didAcceptedByBuddy:(NSString *)username{
    NSArray *buddyList = [[EaseMob sharedInstance].chatManager buddyList];
    NSLog(@"好友添加请求个数 %@",buddyList);
    [self loadBuddyListFromServer];
}
- (void) loadBuddyListFromServer{
  [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
      self.buddyList = buddyList;
      //刷新表格
      [self.tableView reloadData];
  } onQueue:nil];
}
- (void) didUpdateBuddyList:(NSArray *)buddyList changedBuddies:(NSArray *)changedBuddies isAdd:(BOOL)isAdd{
    NSLog(@"好友列表数据被更新了");
}
/** 是否拒绝好友请求*/
- (void) didReceiveBuddyRequest:(NSString *)username message:(NSString *)message{
    NSLog(@"是否被调用？");
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    NSLog(@"");


}
@end
