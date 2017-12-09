//
//  ZLXTopicModel.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/31.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXTopicModel.h"
#import "ZLXConst.h"
#import "UIView+ZLX.h"
#define ZLXScreenH [UIScreen mainScreen].bounds.size.height
@implementation ZLXTopicModel
+ (NSDictionary *) mj_replacedKeyFromPropertyName{
    
    return @{@"small_image":@"image0",
             @"large_image":@"image1",
             @"middle_image":@"image2",
#warning ID对应服务器的小写id
             @"ID":@"id"
             };
}
- (CGFloat) cellH{
//    //如果已经计算好了cell的高度
    if (_cellH) return _cellH;
    //文字的Y值
    _cellH += 55;
    //文字的高度
    CGSize textMaxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * ZLXMargin, MAXFLOAT);
    _cellH += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + ZLXMargin;
  
    if (self.top_cmt.count) {//最热评论
        //标题
//        _cellH += 21;
        //内容
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = @"";
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *cmtText = cmt[@"content"];
        NSString *username = cmt[@"user"][@"username"];
       NSString *text = [NSString stringWithFormat:@"%@ : %@",username,cmtText];
        _cellH += [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + 2 * ZLXMargin;
    }
    //中间的内容
    if (self.type != ZLXTopicTypeWord) {//中间内容有声音，图片，视频
        
        /** 交叉相乘
         self.width    middleW
         ----------- = -------
         self.height   middleH
         */
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        if (middleH >= ZLXScreenH * 0.8) {//显示的图片超过一个平面的长度，
            middleH = 200;
            self.bigPicture = YES;
        }
        CGFloat middleY = _cellH;
        CGFloat middleX = ZLXMargin;
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellH += middleH + ZLXMargin;
    }
    //工具条
    _cellH += ZLXMargin + 35;
    return _cellH;
}
/** //文字的Y值
 cellH += 55;
 //文字的高度
 CGSize textSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * ZLXMargin, MAXFLOAT);
 cellH += [model.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + ZLXMargin;
 cellH += 35 + ZLXMargin;
*/
+ (NSDictionary *) mj_objectClassInArray{
    return @{@"top_cmt":@"ZLXComment"};
}
@end
