//
//  ZLXFriendGroupModel.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/12.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXFriendGroupModel.h"
#import "ZLXFriendModel.h"
@implementation ZLXFriendGroupModel
- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype) friendGroupWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}
+ (NSArray *) friendGroupsList{
   //加载plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
    NSMutableArray *tmpArray = [NSMutableArray array];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dic in dicArray) {
        ZLXFriendGroupModel *friendGroup = [ZLXFriendGroupModel friendGroupWithDic:dic];
        //字典转模型
        NSMutableArray *tmpFriendsArray = [NSMutableArray array];
        for (NSDictionary *friendDic in friendGroup.friends) {
            ZLXFriendModel *friend = [ZLXFriendModel friendWithDic:friendDic];
            [tmpFriendsArray addObject:friend];
        }
        friendGroup.friends = tmpFriendsArray;
        
        [tmpArray addObject:friendGroup];
    }
    return tmpArray;
}
@end
