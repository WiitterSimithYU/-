//
//  ZLXCacheTool.h
//  真有趣
//
//  Created by zlx on 2017/3/26.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZLXTopicModel;
@interface ZLXCacheTool : NSObject
/** 缓存一条数据*/
+ (void) addStatus:(NSDictionary *) dict;
/** 缓存多条数据*/
+ (void) ZLX_addStatuses:(NSArray *) dictArray;
/** 读取缓存*/
+ (NSArray *) ReadCache;
/** json串转换*/
- (NSString *) getJsonStr:(NSDictionary *) dict;
@end
