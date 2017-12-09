//
//  ZLXTopicModel.h
//  真有趣
//
//  Created by Lixin Zhou on 16/8/31.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import <UIKit/UIKit.h>
#import "ZLXTopCmtModel.h"
@interface ZLXTopicModel : NSObject<MJKeyValue>
/** 视频播放地址*/
@property (nonatomic,copy) NSString *videouri;
/** 音频播放时长*/
@property (nonatomic,assign) NSInteger voicetime;
/** 音频播放地址*/
@property (nonatomic,copy) NSString *voiceuri;
/** 音频播放的次数*/
@property (nonatomic,assign) NSInteger playcount;
/** 昵称*/
@property (nonatomic,copy) NSString *name;
/** 头像*/
@property (nonatomic,copy) NSString *profile_image;
/** 发帖时间*/
@property (nonatomic,copy) NSString *create_time;
/** 文字内容*/
@property (nonatomic,copy) NSString *text;
/** 顶的数量*/
@property (nonatomic,assign) NSInteger ding;
/** 踩的数量*/
@property (nonatomic,assign) NSInteger cai;
/** 转发的数量*/
@property (nonatomic,assign) NSInteger repost;
/** 评论的数量*/
@property (nonatomic,assign) NSInteger comment;
/** cell的高度*/
@property (nonatomic,assign) CGFloat cellH;
/** 小图*/
@property (nonatomic,copy) NSString *small_image;
/** 中图*/
@property (nonatomic,copy) NSString *middle_image;
/** 大图*/
@property (nonatomic,copy) NSString *large_image;
/** 图片的frame*/
@property (nonatomic,assign,readonly) CGRect pictureF;
/** 声音的frame*/
@property (nonatomic,assign,readonly) CGRect voiceF;
/** 视频的frame*/
@property (nonatomic,assign,readonly) CGRect videoF;
/** 工具栏的frame*/
@property (nonatomic,assign,readonly) CGRect ToolF;
/** 评论数据*/
@property (nonatomic,strong) NSArray *top_cmt;
/** 用户ID*/
@property (nonatomic,copy) NSString *ID;
/**判断图片是否过大 */
@property (nonatomic,assign,getter=isBigPicture) BOOL bigPicture;
/** cell的类型*/
@property (nonatomic,assign) ZLXTopicType type;
/** 图片的宽度*/
@property (nonatomic,assign) CGFloat width;
/** 图片的高度*/
@property (nonatomic,assign) CGFloat height;
/** 中间内容的frame*/
@property (nonatomic,assign) CGRect middleFrame;
/** 视频播放时长*/
@property (nonatomic,assign) NSInteger videotime;
@end
