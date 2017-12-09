//
//  ZLXCommentCell.h
//  有趣道
//
//  Created by Lixin Zhou on 16/8/23.
//  Copyright © 2016年 ZLX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLXCommentModel.h"
@class ZLXCommentModel;
@interface ZLXCommentCell : UITableViewCell
+ (instancetype) initWithTableview:(UITableView *) tableview;
@property (nonatomic,strong) ZLXCommentModel *comment;
@end
