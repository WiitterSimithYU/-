//
//  ZLXFriendModel.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/12.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXFriendModel.h"

@implementation ZLXFriendModel
- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype) friendWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}
@end
