//
//  ZLXRegisterView.m
//  真有趣
//
//  Created by Lixin Zhou on 16/9/10.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXRegisterView.h"
#import "UIView+ZLX.h"
@interface ZLXRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *RegisterBtn;
@end
@implementation ZLXRegisterView
+ (instancetype) initWithRegisterView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (void) awakeFromNib{
    [super awakeFromNib];
    UIImage *image = self.RegisterBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:self.RegisterBtn.width * 0.5 topCapHeight:self.RegisterBtn.height * 0.5];
    [self.RegisterBtn setBackgroundImage:image forState:UIControlStateNormal];
}
@end
