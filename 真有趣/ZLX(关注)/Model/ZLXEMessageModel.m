//
//  ZLXEMessageModel.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/15.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXEMessageModel.h"
#import "EMBuddy.h"
#import "EaseMob.h"
@implementation ZLXEMessageModel
//- (CGFloat) cellHeight{
//    if (!_cellHeight) {
//                CGFloat margin = 10;
//        //        //获取屏幕的宽度
//                CGFloat ScreenW = [UIScreen mainScreen].bounds.size.width;
////                //时间frame
////                CGFloat timeW = ScreenW;
////                CGFloat timeH = 40;
////                CGFloat timeXY = 0;
////                if (!self.isHiddenTime) {
////                    _timeFrame = CGRectMake(timeXY, timeXY, timeW, timeH);
////                }
////                //头像
////                CGFloat iconW = 50;
////                CGFloat iconH = 50;
////                CGFloat iconY = CGRectGetMaxY(self.timeFrame);
////                CGFloat iconX = 0;
////                if (self.type == ZLXMessageTypeSelf) {
////                    iconX = ScreenW - iconW - margin;
////                }else{
////                    iconX = margin;
////                }
////                _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
//        // 1.获取消息体
//        id body = self.messageBodies[0];
//        if ([body isKindOfClass:[EMTextMessageBody class]]) {//文本消息
//            EMTextMessageBody *textBody = body;
//            //内容
//            CGSize maxSize = CGSizeMake(150, MAXFLOAT);
//            CGSize textSize = [textBody.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
//            CGFloat textY = 10;
//            CGFloat textX = 0;
//            CGSize buttonSize = CGSizeMake(textSize.width + 40, textSize.height + 40);
//            if ([self.from isEqualToString:self.buddy.username]) {//接收方
//                textX = margin;
//            }else{//己方
//                textX = CGRectGetMaxX(self.iconFrame) + margin;
//            }
//            _textFrame = CGRectMake(textX, textY, buttonSize.width, buttonSize.height);
//        }else{
//           
//        }
//                //计算行高
////                CGFloat iconMaxY = CGRectGetMaxY(_iconFrame);
////                CGFloat textMaxY = CGRectGetMaxY(_textFrame);
//                _cellHeight = CGRectGetMaxY(_textFrame) + margin;
//    
//    
//    }
//    return _cellHeight;
//    
//    
//    
//}
@end
