//
//  ZLXFriendCell.h
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/13.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLXFriendModel;
@class EMBuddy;
@interface ZLXFriendCell : UITableViewCell
+ (instancetype) cellWithFriendWith:(UITableView *) tableview;
@property (nonatomic,strong) ZLXFriendModel *friends;
@property (nonatomic,strong) EMBuddy *Buddy;
@end
