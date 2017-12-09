//
//  ZLXMessageModel.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/12.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//
#import "ZLXMessageModel.h"
@implementation ZLXMessageModel
//- (instancetype) initWithDic:(NSDictionary *)dic{
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dic];
//    }
//    return self;
//}
//+ (instancetype) messageWithDic:(NSDictionary *)dic{
//    return [[self alloc] initWithDic:dic];
//}
//+ (NSArray *) messageList{
//   //读取plist
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
//    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
//    //字典转模型
//    NSMutableArray *tmArray = [NSMutableArray array];
//    //上一条消息
//    ZLXMessageModel *preMessage;
//    for (NSDictionary *dic in dicArray) {
//        ZLXMessageModel *message = [self messageWithDic:dic];
////        preMessage = [tmArray lastObject];
//        if ([message.time isEqualToString:preMessage.time]) {
//            //隐藏相同时间
//            message.HiddenTime = YES;
//        }
//        [tmArray addObject:message];
//        preMessage = message;
//    }
//    return tmArray;
//}
//- (CGFloat) cellHeight{
//
//    if (!_cellHeight) {
//        CGFloat margin = 10;
//        //获取屏幕的宽度
//        CGFloat ScreenW = [UIScreen mainScreen].bounds.size.width;
//        //时间frame
//        CGFloat timeW = ScreenW;
//        CGFloat timeH = 40;
//        CGFloat timeXY = 0;
//        if (!self.isHiddenTime) {
//            _timeFrame = CGRectMake(timeXY, timeXY, timeW, timeH);
//        }
//        //头像
//        CGFloat iconW = 50;
//        CGFloat iconH = 50;
//        CGFloat iconY = CGRectGetMaxY(self.timeFrame);
//        CGFloat iconX = 0;
//        if (self.type == ZLXMessageTypeSelf) {
//            iconX = ScreenW - iconW - margin;
//        }else{
//            iconX = margin;
//        }
//        _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
//        //内容
//        CGSize maxSize = CGSizeMake(150, MAXFLOAT);
//        CGSize textSize = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
//        CGFloat textY = iconY;
//        CGFloat textX = 0;
//        CGSize buttonSize = CGSizeMake(textSize.width + 40, textSize.height + 40);
//        if (self.type == ZLXMessageTypeSelf) {
//            textX = iconX - buttonSize.width -  margin;
//        }else{
//            textX = CGRectGetMaxX(self.iconFrame) + margin;
//        }
//        _textFrame = CGRectMake(textX, textY, buttonSize.width, buttonSize.height);
//        //    if (textY > iconY) {
//        //        _rowHeight = CGRectGetMaxY(_textFrame) + margin;
//        //    }else{
//        //        _rowHeight = CGRectGetMaxY(_iconFrame) + margin;
//        //    }
//        //计算行高
//        CGFloat iconMaxY = CGRectGetMaxY(_iconFrame);
//        CGFloat textMaxY = CGRectGetMaxY(_textFrame);
//        _cellHeight = MAX(iconMaxY, textMaxY) + margin;
//
//    }
//    return _cellHeight;
//}
@end
