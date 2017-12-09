//
//  NSDate+ZLXExtension.h
//  01-有趣道
//
//  Created by ZLX on 16/5/16.
//  Copyright (c) 2016年 ZLX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZLXExtension)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
@end
