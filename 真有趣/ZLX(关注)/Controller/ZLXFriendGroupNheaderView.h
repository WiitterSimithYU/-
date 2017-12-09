//
//  ZLXFriendGroupNheaderView.h
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/13.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLXFriendGroupModel,ZLXFriendGroupNheaderView;
@protocol ZLXFriendGroupNheaderViewDelegate <NSObject>
@optional
- (void) headerViewDidClickedNameBtn:(ZLXFriendGroupNheaderView *) headerView;
@end
@interface ZLXFriendGroupNheaderView : UITableViewHeaderFooterView
@property (nonatomic,strong) ZLXFriendGroupModel *friendGroup;
@property (nonatomic,weak) id<ZLXFriendGroupNheaderViewDelegate> delegate;
+ (instancetype) headerViewWithTableView:(UITableView *) tableView;
@end
