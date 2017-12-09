//
//  ZLXEMessageModel.h
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/15.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "EMMessage.h"
@class EMBuddy;
@interface ZLXEMessageModel : EMMessage
/** cell的高度*/
@property (nonatomic,assign) CGFloat cellHeight;
/** 时间frame*/
@property (nonatomic,assign) CGRect timeFrame;
/** 头像frame*/
@property (nonatomic,assign) CGRect iconFrame;
/** 内容frame*/
@property (nonatomic,assign) CGRect textFrame;
/** 好友 */
@property (nonatomic, strong) EMBuddy *buddy;
@end
