//
//  ZLXSubViewCell.h
//  真有趣
//
//  Created by Lixin Zhou on 16/9/2.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLXSubModel;
@interface ZLXSubViewCell : UITableViewCell
+ (instancetype) initWithTableViewCell:(UITableView *)tableview ;
@property (nonatomic,strong) ZLXSubModel *Model;
@end
