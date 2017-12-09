//
//  ZLXMessageModel.h
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/12.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
  
   ZLXMessageTypeSelf,
   ZLXMessageTypeOther

}ZLXMessageType;
@interface ZLXMessageModel : NSObject
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,assign) ZLXMessageType type;
/** 记录是否隐藏时间(默认NO)*/
@property (nonatomic,assign,getter=isHiddenTime) BOOL HiddenTime;
/** cell的高度*/
@property (nonatomic,assign) CGFloat cellHeight;
/** 时间frame*/
@property (nonatomic,assign) CGRect timeFrame;
/** 头像frame*/
@property (nonatomic,assign) CGRect iconFrame;
/** 内容frame*/
@property (nonatomic,assign) CGRect textFrame;
- (instancetype) initWithDic:(NSDictionary *) dic;
+ (instancetype) messageWithDic:(NSDictionary *) dic;
+ (NSArray *) messageList;

@end
