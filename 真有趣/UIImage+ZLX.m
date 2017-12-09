//
//  UIImage+ZLX.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "UIImage+ZLX.h"

@implementation UIImage (ZLX)
+ (UIImage *) imageWithRander:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
- (instancetype) circelWithImage{
    //1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.描述因素：当前点与像素的比例
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //3.设置剪裁区域
    [path addClip];
    //4.画图片
    [self drawAtPoint:CGPointZero];
    //5.取出图片
   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭图形上下文
    UIGraphicsEndImageContext();
    return image;
}
+ (instancetype) ZLX_circleImageNamed:(NSString *)name{
    return [[self imageNamed:name]circelWithImage];
}
//+ (UIImage *) image{
//    return nil;
//}
@end
