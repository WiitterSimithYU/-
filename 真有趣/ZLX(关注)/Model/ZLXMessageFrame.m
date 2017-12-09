//
//  ZLXMessageFrame.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/13.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXMessageFrame.h"
#import "ZLXMessageModel.h"
@implementation ZLXMessageFrame
- (void) setMessage:(ZLXMessageModel *)message{
    _message = message;
    CGFloat margin = 10;
    //获取屏幕的宽度
    CGFloat ScreenW = [UIScreen mainScreen].bounds.size.width;
    //时间frame
    CGFloat timeW = ScreenW;
    CGFloat timeH = 40;
    CGFloat timeXY = 0;
    if (!message.isHiddenTime) {
        _timeFrame = CGRectMake(timeXY, timeXY, timeW, timeH);
    }
    //头像
    CGFloat iconW = 50;
    CGFloat iconH = 50;
    CGFloat iconY = CGRectGetMaxY(self.timeFrame);
    CGFloat iconX = 0;
    if (message.type == ZLXMessageTypeSelf) {
        iconX = ScreenW - iconW - margin;
    }else{
        iconX = margin;
    }
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    //内容
    CGSize maxSize = CGSizeMake(150, MAXFLOAT);
    CGSize textSize = [message.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    CGFloat textY = iconY;
    CGFloat textX = 0;
    CGSize buttonSize = CGSizeMake(textSize.width + 40, textSize.height + 40);
    if (message.type == ZLXMessageTypeSelf) {
        textX = iconX - buttonSize.width -  margin;
    }else{
        textX = CGRectGetMaxX(self.iconFrame) + margin;
    }
    _textFrame = CGRectMake(textX, textY, buttonSize.width, buttonSize.height);
//    if (textY > iconY) {
//        _rowHeight = CGRectGetMaxY(_textFrame) + margin;
//    }else{
//        _rowHeight = CGRectGetMaxY(_iconFrame) + margin;
//    }
    //计算行高
    CGFloat iconMaxY = CGRectGetMaxY(_iconFrame);
    CGFloat textMaxY = CGRectGetMaxY(_textFrame);
    _rowHeight = MAX(iconMaxY, textMaxY) + margin;
}
//- (void) setMessage:(EMMessage *)message{
//
//    _message = message;
//    _message = message;
//    CGFloat margin = 10;
//    //获取屏幕的宽度
//    CGFloat ScreenW = [UIScreen mainScreen].bounds.size.width;
//    //时间frame
//    CGFloat timeW = ScreenW;
//    CGFloat timeH = 40;
//    CGFloat timeXY = 0;
//    if (!message.isHiddenTime) {
//        _timeFrame = CGRectMake(timeXY, timeXY, timeW, timeH);
//    }
//    //头像
//    CGFloat iconW = 50;
//    CGFloat iconH = 50;
//    CGFloat iconY = CGRectGetMaxY(self.timeFrame);
//    CGFloat iconX = 0;
//    if (message.type == ZLXMessageTypeSelf) {
//        iconX = ScreenW - iconW - margin;
//    }else{
//        iconX = margin;
//    }
//    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
//    //内容
//    CGSize maxSize = CGSizeMake(150, MAXFLOAT);
//    CGSize textSize = [message.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
//    CGFloat textY = iconY;
//    CGFloat textX = 0;
//    CGSize buttonSize = CGSizeMake(textSize.width + 40, textSize.height + 40);
//    if (message.type == ZLXMessageTypeSelf) {
//        textX = iconX - buttonSize.width -  margin;
//    }else{
//        textX = CGRectGetMaxX(self.iconFrame) + margin;
//    }
//    _textFrame = CGRectMake(textX, textY, buttonSize.width, buttonSize.height);
//    //    if (textY > iconY) {
//    //        _rowHeight = CGRectGetMaxY(_textFrame) + margin;
//    //    }else{
//    //        _rowHeight = CGRectGetMaxY(_iconFrame) + margin;
//    //    }
//    //计算行高
//    CGFloat iconMaxY = CGRectGetMaxY(_iconFrame);
//    CGFloat textMaxY = CGRectGetMaxY(_textFrame);
//    _rowHeight = MAX(iconMaxY, textMaxY) + margin;
//
//
//
//
//}
@end
