//
//  ZLXUserModel.h
//  真有趣
//
//  Created by Lixin Zhou on 2016/9/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXUserModel : NSObject
/** 用户名*/
@property (nonatomic,copy) NSString *username;
/** 性别*/
@property (nonatomic,copy) NSString *sex;
/** 头像*/
@property (nonatomic,copy) NSString *profile_image;

@end
