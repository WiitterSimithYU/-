//
//  ZLXTopicPictureView.m
//  真有趣
//
//  Created by Lixin Zhou on 16/9/21.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXTopicPictureView.h"
#import "ZLXTopicModel.h"
#import "ZLXSeeBigPictureViewController.h"
//#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
@interface ZLXTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *PictureImage;
@property (weak, nonatomic) IBOutlet DACircularProgressView *ProgressView;
@property (weak, nonatomic) IBOutlet UIImageView *GifImage;
- (IBAction)SeeBigImageView:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *SeeBigView;
//@property ()
@end
@implementation ZLXTopicPictureView
- (void) awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    /** 图片添加手势*/
    self.PictureImage.userInteractionEnabled = YES;//允许交互
    [self.PictureImage addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBIgPicture)]];
}
- (void) seeBIgPicture{
    NSLog(@"图片手势添加成功！");
    ZLXSeeBigPictureViewController *SeeVC = [[ZLXSeeBigPictureViewController alloc] init];
    SeeVC.topic = self.pictureModel;
    [self.window.rootViewController presentViewController:SeeVC animated:YES completion:nil];
}
- (void) setPictureModel:(ZLXTopicModel *)pictureModel{
    _pictureModel = pictureModel;

//    [self.PictureImage sd_setImageWithURL:[NSURL URLWithString:pictureModel.middle_image] placeholderImage:[UIImage imageNamed:@""] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
//    [self.PictureImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:pictureModel.middle_image] placeholderImage:[UIImage imageNamed:@"mainCellBackground"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        self.ProgressView.hidden = NO;
//        CGFloat progress = 1.0 * receivedSize / expectedSize;
//        [self.ProgressView setProgress:progress animated:YES];
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.ProgressView.hidden = YES;
//    }];
//    if ([pictureModel.large_image.lowercaseString hasSuffix:@"gif"]) { 第一种方法
//        self.GifImage.hidden = NO;
//    }else{
//        self.GifImage.hidden = YES;
//    }
    [self.PictureImage sd_setImageWithURL:[NSURL URLWithString:pictureModel.middle_image] placeholderImage:[UIImage imageNamed:@"progress-bar1"]];
    if ([pictureModel.large_image.pathExtension.lowercaseString isEqualToString:@"gif"]) {//第二种方法
        self.GifImage.hidden = NO;
    }else{
        self.GifImage.hidden = YES;
    }
    if (pictureModel.isBigPicture) {
        self.SeeBigView.hidden = NO;
        self.PictureImage.contentMode = UIViewContentModeTop;
        self.PictureImage.clipsToBounds = YES;
        if (self.PictureImage.image) {
            CGFloat imageW = pictureModel.middleFrame.size.width;
            CGFloat imageH = imageW * pictureModel.height / pictureModel.width;
            //开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            //绘制图片到上下行文
            [self.PictureImage.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            //取出图片
            self.PictureImage.image = UIGraphicsGetImageFromCurrentImageContext();
            //关闭上下文
            UIGraphicsEndImageContext();
        }
    }else{
        self.SeeBigView.hidden = YES;
        self.PictureImage.contentMode = UIViewContentModeScaleToFill;
        self.PictureImage.clipsToBounds = NO;
    }
}
- (IBAction)SeeBigImageView:(UIButton *)sender {
    ZLXSeeBigPictureViewController *SeeVC = [[ZLXSeeBigPictureViewController alloc] init];
    SeeVC.topic = self.pictureModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:SeeVC animated:YES completion:nil];
}
@end
