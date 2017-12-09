//
//  ZLXMessageFrame.h
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/13.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZLXMessageModel;
@interface ZLXMessageFrame : NSObject
/** 时间label*/
@property (nonatomic,assign,readonly) CGRect timeFrame;
/** 用户头像*/
@property (nonatomic,assign,readonly) CGRect iconFrame;
/** 内容*/
@property (nonatomic,assign,readonly) CGRect textFrame;
/** 模型数据*/
@property (nonatomic,strong) ZLXMessageModel *message;
/** cell的高度*/
@property (nonatomic,assign,readonly) CGFloat rowHeight;
@end
