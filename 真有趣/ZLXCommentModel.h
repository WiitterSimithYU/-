//
//  ZLXCommentModel.h
//  真有趣
//
//  Created by Lixin Zhou on 2016/9/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZLXUserModel;
@interface ZLXCommentModel : NSObject
/** 创建时间*/
@property (nonatomic,copy) NSString *ctime;
/** 音频文件的时长*/
@property (nonatomic,copy) NSString *voicetime;
/** 评论的文字内容*/
@property (nonatomic,copy) NSString *content;
/** 被点赞的数量*/
@property (nonatomic,assign) NSInteger like_count;
/** 用户信息*/
@property (nonatomic,strong) ZLXUserModel *user;
/** 头像的frame*/
@property (nonatomic,assign,readonly) CGRect iconF;
/** 昵称的frame*/
@property (nonatomic,assign,readonly) CGRect nameF;
/** 内容的frame*/
@property (nonatomic,assign,readonly) CGRect textF;
/** 返回cell的高度*/
@property (nonatomic,assign) CGFloat cellH;
/** 创建时间的frame*/
@property (nonatomic,assign,readonly) CGRect timeF;
@end
