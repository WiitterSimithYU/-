 //
//  ZLXLoginRegisterView.m
//  真有趣
//
//  Created by Lixin Zhou on 16/9/6.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXLoginView.h"


@interface ZLXLoginView ()
@property (weak, nonatomic) IBOutlet UIButton *LonginButton;
@end
@implementation ZLXLoginView

+ (instancetype) initWithLoginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
- (void) awakeFromNib{
    /** 禁止自动拉伸图片*/
    [super awakeFromNib];
    UIImage *image = self.LonginButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.LonginButton setBackgroundImage:image forState:UIControlStateNormal];
}

@end
 
