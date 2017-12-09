//
//  UIImage+ZLX.h
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZLX)
+ (UIImage *) imageWithRander:(NSString *) imageName;
/** 返回一张圆形的图片*/
- (instancetype) circelWithImage;
+ (instancetype) ZLX_circleImageNamed:(NSString *) name;
//+ (UIImage *) image;
@end
