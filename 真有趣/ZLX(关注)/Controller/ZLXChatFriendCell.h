//
//  ZLXChatFriendCell.h
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/13.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseMob.h"
//@class ZLXMessageModel;
@class ZLXEMessageModel;
@class EMBuddy;
@class ZLXFriendCell;
@protocol ZLXFriendCellDelegate <NSObject>

-(void)CellForHeight:(CGFloat)height;

@end
@interface ZLXChatFriendCell : UITableViewCell
//@property (nonatomic,strong) ZLXMessageModel *message;
+ (instancetype) cellWithTableview:(UITableView *) tableview;
/** 消息模型*/
@property (nonatomic,strong) EMMessage *message;
@property (nonatomic,strong) EMBuddy *buddy;
/** cell的高度*/
@property (nonatomic,assign) CGFloat cellHeight;
/** 设置代理属性*/
@property (nonatomic,weak) id<ZLXFriendCellDelegate> delegate;
@end
