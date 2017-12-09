//
//  ZLXChatFriendViewController.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/13.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXChatFriendViewController.h"
#import "ZLXMessageModel.h"
#import "ZLXMessageModel.h"
#import "ZLXChatFriendCell.h"
#import "EaseMob.h"
#import "ZLXEMessageModel.h"
@interface ZLXChatFriendViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,ZLXFriendCellDelegate,EMChatManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottomConstraint;
@property (nonatomic,strong) NSArray *message;
@property (nonatomic,strong) NSMutableDictionary *heights;
/** 记录cell的高度*/
@property (nonatomic,assign) CGFloat cellHeight;
/** 真实的数据*/
@property (nonatomic,strong) NSMutableArray *dataSources;
/** 键盘的属性*/
@property (weak, nonatomic) IBOutlet UITextView *textview;
@end

@implementation ZLXChatFriendViewController
/** 懒加载cell的高度*/
- (NSMutableDictionary *) heights{
    if (_heights == nil) {
        _heights = [NSMutableDictionary dictionary];
    }
    return _heights;
}
//- (NSArray *) messageFrames{
//    if (_messageFrames == nil) {
//        NSArray *messages = [ZLXMessageModel messageList];
//        NSMutableArray *temArray = [NSMutableArray array];
//        for (ZLXMessageModel *msg in messages) {
//            ZLXMessageFrame *msgFrame = [[ZLXMessageFrame alloc] init];
//            msgFrame.message = msg;
//            [temArray addObject:msgFrame];
//        }
//        _messageFrames = temArray;
//    }
//    return _messageFrames;
//}
/** 懒加载真实数据*/
- (NSMutableArray *) dataSources{
    if (_dataSources == nil) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}
/** 懒加载数据*/
//- (NSArray *) message{
//    if (_message == nil) {
//        _message = [ZLXMessageModel messageList];
//    }
//    return _message;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([self.message.from isEqualToString:self.buddy.username]) {
//        
//    }
    NSLog(@"%@",_dataSources);
    self.textview.keyboardType = UIReturnKeySend;
//    self.tableView.rowHeight = 100;
    self.textview.delegate = self;
    /** 加载本地的聊天记录*/
    [self loadLocationChatRecords];
//    [self.tableView reloadData];
    self.title = [NSString stringWithFormat:@"与 %@ 聊天中",self.buddy.username];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //不能选中
    self.tableView.allowsSelection = NO;
    //背景颜色
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    //监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbwillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘的退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbwilldismiss:) name:UIKeyboardWillHideNotification object:nil];
    /** 监听好友回复消息的代理*/
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}
/** 加载本地聊天记录*/
- (void) loadLocationChatRecords{
    // 要获取本地聊天记录使用 会话对象
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.buddy.username conversationType:eConversationTypeChat];
    
    // 加载与当前聊天用户所有聊天记录
    NSArray *messages = [conversation loadAllMessages];
//    
//    for (id obj in messages) {
////        NSLog(@"%@",[obj class]);
//    }
    // 添加到数据源
    [self.dataSources addObjectsFromArray:messages];
}
/** 监听键盘的退出*/
- (void) kbwilldismiss:(NSNotification *) noti{
    self.inputViewBottomConstraint.constant = 0;
}
/** 监听键盘的弹出*/
- (void) kbwillShow:(NSNotification *) noti{
   //获取键盘的高度
    CGRect kbEndFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat kbHeight = kbEndFrame.size.height;
    //更改view的底部约束
    self.inputViewBottomConstraint.constant = kbHeight;
    //添加动画
    [UIView  animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.dataSources.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXChatFriendCell *cell = [ZLXChatFriendCell cellWithTableview:tableView];
    cell.delegate = self;
    cell.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    EMMessage *message = self.dataSources[indexPath.row];
    cell.message = message;
    /** 存储cell的高度*/
//    self.heights[@(indexPath.row)] = @(cell.height);
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ZLXEMessageModel *message = self.dataSources[indexPath.row];
//   ZLXChatFriendCell *cell = [ZLXChatFriendCell cellWithTableview:tableView];
//    EMMessage *message = self.dataSources[indexPath.row];
//    cell.message = message;
////    //强制布局
//    [cell layoutIfNeeded];
//    return [self.heights[@(indexPath.row)]doubleValue];
    return self.cellHeight;
//    return 50;
}
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.textview endEditing:YES];
}
- (void) textViewDidChange:(UITextView *)textView{
    //监听send时间 --- 判断最后一个字符是不是换行字符
    if ([textView.text hasSuffix:@"\n"]) {
        NSLog(@"发送操作");
        [self sendMessage:textView.text];
        //清空文字
        textView.text = nil;
    }
}
- (void) sendMessage:(NSString *) text{
    // 把最后一个换行字符去除
#warning 换行字符 只占用一个长度
    text = [text substringToIndex:text.length - 1];
    //消息 ＝ 消息头 + 消息体
#warning 每一种消息类型对象不同的消息体
    //    EMTextMessageBody 文本消息体
    //    EMVoiceMessageBody 录音消息体
    //    EMVideoMessageBody 视频消息体
    //    EMLocationMessageBody 位置消息体
    //    EMImageMessageBody 图片消息体
    NSLog(@"要发送给 %@",self.buddy.username);
    //    return;
    // 创建一个聊天文本对象
    EMChatText *chatText = [[EMChatText alloc] initWithText:text];
    //创建一个文本消息体
    EMTextMessageBody *textBody = [[EMTextMessageBody alloc] initWithChatObject:chatText];
    //1.创建一个消息对象
    EMMessage *msgObj = [[EMMessage alloc] initWithReceiver:self.buddy.username bodies:@[textBody]];
    // 消息类型
    //    @constant eMessageTypeChat            单聊消息
    //    @constant eMessageTypeGroupChat       群聊消息
    //    @constant eMessageTypeChatRoom        聊天室消息
    msgObj.messageType = eMessageTypeChat;
    // 2.发送消息
    [[EaseMob sharedInstance].chatManager asyncSendMessage:msgObj progress:nil prepare:^(EMMessage *message, EMError *error) {
        NSLog(@"准备发送消息");
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        NSLog(@"完成消息发送 %@",error);
    } onQueue:nil];
    // 3.把消息添加到数据源，然后再刷新表格
    [self.dataSources addObject:msgObj];
    NSLog(@"ZLXZLX %zd",self.dataSources.count);
    [self.tableView reloadData];
    [self scrollToBottom];
}
- (void) CellForHeight:(CGFloat)height{
    self.cellHeight = height;
}
#pragma 监听好友回复的消息
- (void) didReceiveMessage:(EMMessage *)message{
   //把接受的消息添加到数据源中
    [self.dataSources addObject:message];
    //刷新表格
    [self.tableView reloadData];
    //显示shu
    [self scrollToBottom];
}
-(void)scrollToBottom{
    //1.获取最后一行
    if (self.dataSources.count == 0) {
        return;
    }
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.dataSources.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
