//
//  ZLXTopicCell.h
//  真有趣
//
//  Created by Lixin Zhou on 16/9/19.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLXTopicModel;
@class ZLXTopCmtModel;
@interface ZLXTopicCell : UITableViewCell
@property (nonatomic,strong) ZLXTopicModel *TopicModel;
+ (instancetype) initWithCell;
@end
