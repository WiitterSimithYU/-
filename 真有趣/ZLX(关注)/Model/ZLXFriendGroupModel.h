//
//  ZLXFriendGroupModel.h
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/12.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXFriendGroupModel : NSObject
/** 分组名称*/
@property (nonatomic,copy) NSString *name;
/** 在线的好友*/
@property (nonatomic,assign) NSInteger online;
/** 记录是否合并，默认为no*/
@property (nonatomic,assign,getter=isExpend) BOOL expend;
/** 数组*/
@property (nonatomic,strong) NSArray *friends;
- (instancetype) initWithDic:(NSDictionary *) dic;
+ (instancetype) friendGroupWithDic:(NSDictionary *) dic;
+ (NSArray *) friendGroupsList;
@end
