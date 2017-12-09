//
//  ZLXChatFriendCell.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/13.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXChatFriendCell.h"
#import "ZLXMessageFrame.h"
#import "ZLXMessageModel.h"
#import "UIImage+ZLX.h"
#import "ZLXEMessageModel.h"
@interface ZLXChatFriendCell ()
//时间
@property (nonatomic,weak) UILabel *timeView;
//头像
@property (nonatomic,weak) UIImageView *iconView;
//内容
@property (nonatomic,weak) UIButton *textView;
//@property (nonatomic,strong) EMTextMessageBody *textbody;
@end
@implementation ZLXChatFriendCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
+ (instancetype) cellWithTableview:(UITableView *)tableview{
    static NSString *reuseID = @"chatcell";
    ZLXChatFriendCell *cell = [tableview dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
    }
    return cell;
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建子控件
        [self setupChildView];
    }
    return self;
}
- (void) setupChildView{
    //时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.textAlignment = NSTextAlignmentCenter;
    self.timeView = timeView;
    [self.contentView addSubview:timeView];
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    //设置圆角
    iconView.layer.cornerRadius = 25;
    iconView.layer.masksToBounds = YES;
    self.iconView = iconView;
    [self.contentView addSubview:iconView];
    //聊天内容
    UIButton *textView = [[UIButton alloc] init];
    textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    self.textView = textView;
    textView.titleLabel.font = [UIFont systemFontOfSize:13];
    textView.titleLabel.numberOfLines = 0;
    [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:textView];
}
//- (void) setMessageFrame:(ZLXMessageFrame *)messageFrame{
//    _messageFrame = messageFrame;
//    //给子控件赋值
//    self.timeView.text = messageFrame.message.time;
//    [self.textView setTitle:messageFrame.message.text forState:UIControlStateNormal];
//    if (messageFrame.message.type == ZLXMessageTypeSelf) {
//        [self.textView setBackgroundImage:[self resizeImage:@"chat_send_nor"] forState:UIControlStateNormal];
//        [self.textView setBackgroundImage:[self resizeImage:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
//    }else{
//        [self.textView setBackgroundImage:[self resizeImage:@"chat_recive_nor"] forState:UIControlStateNormal];
//        [self.textView setBackgroundImage:[self resizeImage:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
//    }
//    NSString *imgName = messageFrame.message.type == ZLXMessageTypeSelf ? @"me" : @"other";
//    self.iconView.image = [UIImage imageNamed:imgName];
//    //设置子控件的frame
//    self.textView.frame = messageFrame.textFrame;
//    self.iconView.frame = messageFrame.iconFrame;
//    self.timeView.frame = messageFrame.timeFrame;
//    //    //时间是否隐藏
//    //    if (!messageFrame.message.isHiddenTime) {
//    //    self.timeView.frame = messageFrame.timeFrame;
//    //    }else{
//    //        self.timeView.frame = CGRectZero;
//    //
//    //    }
//}
//- (void) setMessage:(ZLXMessageModel *)message{
//    _message = message;
//    //给子控件赋值
//    self.timeView.text = message.time;
//    [self.textView setTitle:message.text forState:UIControlStateNormal];
//    if (message.type == ZLXMessageTypeSelf) {
//        [self.textView setBackgroundImage:[self resizeImage:@"chat_send_nor"] forState:UIControlStateNormal];
//        [self.textView setBackgroundImage:[self resizeImage:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
//    }else{
//        [self.textView setBackgroundImage:[self resizeImage:@"chat_recive_nor"] forState:UIControlStateNormal];
//        [self.textView setBackgroundImage:[self resizeImage:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
//    }
//    NSString *imgName = message.type == ZLXMessageTypeSelf ? @"me" : @"other";
//    self.iconView.image = [UIImage imageNamed:imgName];
//    //设置子控件的frame
//    self.textView.frame = message.textFrame;
//    self.iconView.frame = message.iconFrame;
//    self.timeView.frame = message.timeFrame;
//    //    //时间是否隐藏
//    //    if (!messageFrame.message.isHiddenTime) {
//    //    self.timeView.frame = messageFrame.timeFrame;
//    //    }else{
//    //        self.timeView.frame = CGRectZero;
//    //
//    //    }
//
//
//}
//- (void) setMessage:(EMMessage *)message{
//    _message = message;
//     //获取消息体
//    id body = message.messageBodies[0];
//    if ([body isKindOfClass:[EMTextMessageBody class]]) {//文本消息
//        EMTextMessageBody *textbody = body;
//        [self.textView setTitle:textbody.text forState:UIControlStateNormal];
//    }else{
//        [self.textView setTitle:@"未知类型" forState:UIControlStateNormal];
//    }
//}
- (void) setMessage:(EMMessage *)message{
    _message = message;
    //获取消息体
    id body = message.messageBodies[0];
    EMTextMessageBody *textbody = body;
//    self.textbody = textbody;
    if ([body isKindOfClass:[EMTextMessageBody class]]) {
        CGFloat textX;
        CGFloat textY;
        CGFloat ScreenW = [UIScreen mainScreen].bounds.size.width;
        if ([body isKindOfClass:[EMTextMessageBody class]]) {//文本消息
            CGSize maxSzie = CGSizeMake(150, MAXFLOAT);
            CGSize textSize = [textbody.text boundingRectWithSize:maxSzie options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            CGSize buttonSize = CGSizeMake(textSize.width + 40, textSize.height + 40);
            if (![self.message.from isEqualToString:self.buddy.username]) {//己方
                textX = ScreenW - buttonSize.width;
                textY = 0;
                [self.textView setTitle:textbody.text forState:UIControlStateNormal];
                [self.textView setBackgroundImage:[self resizeImage:@"chat_send_nor"] forState:UIControlStateNormal];
                [self.textView setBackgroundImage:[self resizeImage:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
//                [self.textView setTitle:textbody.text forState:UIControlStateNormal];
            }else if(![self.message.to isEqualToString:self.buddy.username]){
                textX = 0;
//                textY = CGRectGetMaxY(self.textView.frame) + 10;
                textY = 0;
                [self.textView setBackgroundImage:[self resizeImage:@"chat_recive_nor"] forState:UIControlStateNormal];
                [self.textView setBackgroundImage:[self resizeImage:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
                [self.textView setTitle:textbody.text forState:UIControlStateNormal];
            }
            self.textView.frame = CGRectMake(textX, textY, buttonSize.width, buttonSize.height);
            CGFloat height = CGRectGetMaxY(self.textView.frame);
            [self heightWith:height];
        }
    }else{
        [self.textView setTitle:@"未知类型" forState:UIControlStateNormal];
    }
}
//- (void) layoutSubviews{
//    [super layoutSubviews];
//    if ([self.textbody isKindOfClass:[EMTextMessageBody class]]) {
//        
//        CGFloat textX;
//        CGFloat ScreenW = [UIScreen mainScreen].bounds.size.width;
//        if ([self.textbody isKindOfClass:[EMTextMessageBody class]]) {//文本消息
//            CGFloat textY = 10;
//            CGSize maxSzie = CGSizeMake(150, MAXFLOAT);
//            CGSize textSize = [self.textbody.text boundingRectWithSize:maxSzie options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
//            CGSize buttonSize = CGSizeMake(textSize.width + 40, textSize.height + 40);
//            if (![self.message.from isEqualToString:self.buddy.username]) {//发送方
//                textX = 0;
//                [self.textView setTitle:self.textbody.text forState:UIControlStateNormal];
//                [self.textView setBackgroundImage:[self resizeImage:@"chat_send_nor"] forState:UIControlStateNormal];
//                [self.textView setBackgroundImage:[self resizeImage:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
//            }
//            else{
//                textX = ScreenW - buttonSize.width;
//                [self.textView setBackgroundImage:[self resizeImage:@"chat_recive_nor"] forState:UIControlStateNormal];
//                [self.textView setBackgroundImage:[self resizeImage:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
//            }
//            self.textView.frame = CGRectMake(textX, textY, buttonSize.width, buttonSize.height);
//        }
//    }else{
//        [self.textView setTitle:@"未知类型" forState:UIControlStateNormal];
//    }
//
//
//
//}
//缩放图片
- (UIImage *) resizeImage:(NSString *) imageName{
    UIImage *BgImage = [UIImage imageNamed:imageName];
    BgImage = [BgImage stretchableImageWithLeftCapWidth:BgImage.size.width * 0.5 topCapHeight:BgImage.size.height * 0.5];
    return BgImage;
}
//- (void) layoutSubviews{
//    [super layoutSubviews];
//    
//}
/**   CGSize maxSize = CGSizeMake(150, MAXFLOAT);
 CGSize textSize = [message.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
 CGFloat textY = iconY;
 CGFloat textX = 0;
 CGSize buttonSize = CGSizeMake(textSize.width + 40, textSize.height + 40);
 if (message.type == ZLXMessageTypeSelf) {
 textX = iconX - buttonSize.width -  margin;
 }else{
 textX = CGRectGetMaxX(self.iconFrame) + margin;
 }
 _textFrame = CGRectMake(textX, textY, buttonSize.width, buttonSize.height);*/
//- (CGFloat) cellHeight{
//    [self layoutIfNeeded];
//  return CGRectGetMaxY(self.textView.frame) + 10;
//}
- (CGFloat) heightWith:(CGFloat)height{
#warning 在这里将计算好的头视图的高度传给控制器，可以使用MVVM设计模型,MMVM模型就是增加一个视图模型，专门计算frame，同时，它依赖数据模型。
    if ([self.delegate respondsToSelector:@selector(CellForHeight:)]) {
        [self.delegate CellForHeight:height];
    }
    return height;
}
@end
