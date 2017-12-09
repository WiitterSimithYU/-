//
//  UIBarButtonItem+ZLX.h
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZLX)
+ (UIBarButtonItem *) initWithImage:(NSString *) Image HeightImage:(NSString *) HeightImage target:(id) target action:(SEL) action ;
+ (instancetype) BackItemWithImage:(NSString *)  Image HeightImage:(NSString *) HeightImage target:(id) target action:(SEL) action title:(NSString *) title;
@end
