//
//  ZLXSubViewCell.m
//  真有趣
//
//  Created by Lixin Zhou on 16/9/2.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXSubViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZLXSubModel.h"
@interface ZLXSubViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *IconView;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *FoucsLabel;
@property (weak, nonatomic) IBOutlet UIButton *Btn;

@end
@implementation ZLXSubViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.IconView.layer.cornerRadius = 30;
//    self.IconView.layer.masksToBounds = YES;
    self.layoutMargins = UIEdgeInsetsZero;
}
+ (instancetype) initWithTableViewCell:(UITableView *)tableview{
    static NSString *ZLX = @"Subcell";
    ZLXSubViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ZLX];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void) setModel:(ZLXSubModel *)Model{
    _Model = Model;
    [self.IconView sd_setImageWithURL:[NSURL URLWithString:Model.image_list] placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //如果图片下载失败
        if (!image) return;
        //1.开启图形上下文
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //2.描述因素：当前点与像素的比例
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //3.设置剪裁区域
        [path addClip];
        //4.画图片
        [image drawAtPoint:CGPointZero];
        //5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        //6.关闭图形上下文
        UIGraphicsEndImageContext();
        self.IconView.image = image;
    }];
    self.NameLabel.text = Model.theme_name;
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",Model.sub_number];
    NSInteger num = Model.sub_number.integerValue;
    if (num > 1000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];
    }
    self.FoucsLabel.text = numStr;
    self.FoucsLabel.font = [UIFont systemFontOfSize:13];
    self.FoucsLabel.textColor = [UIColor lightGrayColor];
}
@end
