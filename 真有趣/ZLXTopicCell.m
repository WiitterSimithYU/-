//
//  ZLXTopicCell.m
//  真有趣
//
//  Created by Lixin Zhou on 16/9/19.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXTopicCell.h"
#import "UIImageView+WebCache.h"
#import "ZLXTopicModel.h"
#import "UIImage+ZLX.h"
#import "ZLXTopCmtModel.h"
#import "ZLXTopicVideoView.h"
#import "ZLXTopicVoiceView.h"
#import "ZLXTopicPictureView.h"
#import "UIView+ZLX.h"
@interface ZLXTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *HotLabel;
/** 懒加载声音，视频，图片控件*/
@property (nonatomic,weak) ZLXTopicPictureView *pictureView;
@property (nonatomic,weak) ZLXTopicVoiceView *voiceView;
@property (nonatomic,weak) ZLXTopicVideoView *videoView;
@end
@implementation ZLXTopicCell
/** 懒加载声音，视频，图片控件*/
- (ZLXTopicPictureView *) pictureView{
    if (_pictureView == nil) {
        ZLXTopicPictureView *pictureView = [ZLXTopicPictureView ZLX_ViewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
- (ZLXTopicVoiceView *) voiceView{
    if (_voiceView == nil) {
        ZLXTopicVoiceView *voiceView = [ZLXTopicVoiceView ZLX_ViewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
- (ZLXTopicVideoView *) videoView{
    if (_videoView == nil) {
        ZLXTopicVideoView *videoView = [ZLXTopicVideoView ZLX_ViewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
- (void) awakeFromNib{
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = UIViewAutoresizingNone;
//      [self.contentView addSubview:[ZLXTopicPictureView ZLX_ViewFromXib]];
}
/** 提供类方法，加载xib*/
+ (instancetype) initWithCell{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}
- (void) setTopicModel:(ZLXTopicModel *)TopicModel{
    _TopicModel = TopicModel;
    UIImage *placeholder = [UIImage ZLX_circleImageNamed:@"defaultUserIcon"];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:TopicModel.profile_image] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //如果图片下载失败
        if (!image) return;
        self.iconView.image = [image circelWithImage];
    }];
    self.nameLabel.text = TopicModel.name;
    self.timeLabel.text = TopicModel.create_time;
    self.text_Label.text = TopicModel.text;
//    self.HotLabel.text = @"最热评论最热评论最热评论最热评论最热评论最热评论最热评论最热评论最热评论";
    /** 按钮*/
    [self setupBtnTitle:self.zanBtn number:TopicModel.ding placeholder:@"赞"];
    [self setupBtnTitle:self.caiBtn number:TopicModel.cai placeholder:@"踩"];
    [self setupBtnTitle:self.shareBtn number:TopicModel.repost placeholder:@"分享"];
    [self setupBtnTitle:self.messageBtn number:TopicModel.comment placeholder:@"评论"];
    //添加cell的子视图
    if (TopicModel.type == ZLXTopicTypePicture) {//图片
        self.pictureView.pictureModel = TopicModel;//此处传递数据模型
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }else if (TopicModel.type == ZLXTopicTypeVoice){//声音
        self.voiceView.VoiceModel = TopicModel;//此处传递数据模型
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    }else if (TopicModel.type == ZLXTopicTypeVideo){//视频
        self.videoView.VideoModel = TopicModel;//此处传递数据模型
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    if (TopicModel.top_cmt.count) {
        self.HotLabel.hidden = NO;
//        self.text_Label.hidden = YES;
//        self.HotLabel.text = TopicModel.content;
        NSMutableDictionary *cmt = TopicModel.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
//        NSArray *array = cmt[@"list"];
        NSString *username = cmt[@"user"][@"username"];
        self.HotLabel.text = [NSString stringWithFormat:@"最热评论  %@:%@",username,content];
    }else{
        self.HotLabel.hidden = YES;
    }
  }
/** 设置按钮*/
- (void) setupBtnTitle:(UIButton *) button number:(NSInteger) number placeholder:(NSString *) placeholder{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万人",number / 10000.0] forState:UIControlStateNormal];
    }else if (number == 0){
        [button setTitle:placeholder forState:UIControlStateNormal];
    }else{
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }
}
/** 修改cell的frame*/
- (void) setFrame:(CGRect)frame{
    frame.size.height -= 10;
    //    frame.origin.x += 10;
    //    frame.size.width -= 20;
    [super setFrame:frame];
}
- (void) layoutSubviews{
    [super layoutSubviews];
    if (self.TopicModel.type == ZLXTopicTypePicture) {//图片
        self.pictureView.frame = self.TopicModel.middleFrame;
    }else if (self.TopicModel.type == ZLXTopicTypeVoice){//声音
        self.voiceView.frame = self.TopicModel.middleFrame;
    }else if (self.TopicModel.type == ZLXTopicTypeVideo){//视频
        self.videoView.frame = self.TopicModel.middleFrame;
    }
    //如果有必要，需要强制布局
    [self layoutIfNeeded];
}
@end
