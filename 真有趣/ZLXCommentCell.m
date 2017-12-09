//
//  ZLXCommentCell.m
//  有趣道
//
//  Created by Lixin Zhou on 16/8/23.
//  Copyright © 2016年 ZLX. All rights reserved.
//

#import "ZLXCommentCell.h"
#import "ZLXUserModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ZLX.h"
@interface ZLXCommentCell ()
/** 头像*/
@property (nonatomic,weak) UIImageView *iconView;
/** 昵称*/
@property (nonatomic,weak) UILabel *nameLabel;
/** 评论内容*/
@property (nonatomic,weak) UILabel *textView;
/** 创建时间*/
@property (nonatomic,weak) UILabel *timeLabel;

@end

@implementation ZLXCommentCell

+ (instancetype) initWithTableview:(UITableView *)tableview{
    static NSString *ID = @"cell";
    ZLXCommentCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupChildView];
    }
    return self;
}
- (void) setupChildView{
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    [self.contentView addSubview:iconView];
    //昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:nameLabel];
    //内容
    UILabel *textView = [[UILabel alloc] init];
    [self.contentView addSubview:textView];
    textView.font = [UIFont systemFontOfSize:12];
    textView.numberOfLines = 0;
    self.textView = textView;
    //创建时间
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timeLabel];
}
- (void) setComment:(ZLXCommentModel *)comment{
    _comment = comment;
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:nil];
    UIImage *placeholder = [UIImage ZLX_circleImageNamed:@"defaultUserIcon"];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //如果图片下载失败
        if (!image) return;
        self.iconView.image = [image circelWithImage];
    }];
    self.iconView.frame = comment.iconF;
    self.nameLabel.text = comment.user.username;
    self.nameLabel.frame = comment.nameF;
    self.textView.text = comment.content;
    self.textView.frame = comment.textF;
    self.timeLabel.text = comment.ctime;
    self.timeLabel.frame = comment.timeF;
}
@end
