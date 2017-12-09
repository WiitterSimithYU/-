//
//  ZLXFriendModel.h
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/12.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXFriendModel : NSObject
/** 头像*/
@property (nonatomic,copy) NSString *icon;
/** 个性签名**/
@property (nonatomic,copy) NSString *intro;
/** 好友名称*/
@property (nonatomic,copy) NSString *name;
/** 是否是会员*/
@property (nonatomic,assign,getter=isVip) BOOL vip;
- (instancetype) initWithDic:(NSDictionary *) dic;
+ (instancetype) friendWithDic:(NSDictionary *) dic;

@end
