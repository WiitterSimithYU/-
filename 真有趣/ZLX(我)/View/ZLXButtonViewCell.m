//
//  ZLXButtonViewCell.m
//  真有趣
//
//  Created by Lixin Zhou on 16/9/12.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXButtonViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZLXButtonModel.h"
@interface ZLXButtonViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@end
@implementation ZLXButtonViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}
- (void) setModel:(ZLXButtonModel *)model{
    _model = model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];
    self.titleView.text = model.name;
}
@end
