//
//  ZLXCommentModel.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/9/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXCommentModel.h"
#import "ZLXUserModel.h"
@implementation ZLXCommentModel
- (CGFloat) cellH{
    if (!_cellH) {
        //头像
        CGFloat iconX = 10;
        CGFloat iconY = 10;
        CGFloat iconW = 35;
        CGFloat iconH = 35;
        _iconF = CGRectMake(iconX, iconY, iconW, iconH);
        //昵称
        CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
        CGSize nameSize = [self text:self.user.username Font:13 MaxSzie:maxSize];
        CGFloat nameX = CGRectGetMaxX(_iconF) + 10;
        CGFloat nameY = 10;
        _nameF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
        //创建时间
        CGSize timeMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
        CGSize timeSize = [self text:self.ctime Font:12 MaxSzie:timeMaxSize];
        CGFloat timeX = CGRectGetMaxX(_iconF) + 10;
        CGFloat timeY = CGRectGetMaxY(_nameF) + 10;
        _timeF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
        //内容
        CGFloat maxW = [UIScreen mainScreen].bounds.size.width;
        CGSize maxTextSize = CGSizeMake(maxW - 10, MAXFLOAT);
        CGSize textSize = [self text:self.content Font:12 MaxSzie:maxTextSize];
        CGFloat textX = 10;
        CGFloat textY = CGRectGetMaxY(_iconF) + 10;
        _textF = CGRectMake(textX, textY, textSize.width, textSize.height);
        _cellH = CGRectGetMaxY(_textF) + 10;
    }
    return _cellH;
}
- (CGSize) text:(NSString *) text Font:(CGFloat) font MaxSzie:(CGSize) maxSize{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}
@end
