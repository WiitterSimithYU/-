//
//  ZLXDataCacheTool.m
//  真有趣
//
//  Created by Mac on 2017/3/28.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXDataCacheTool.h"
#import "FMDB.h"
#import "ZLXTopicModel.h"
@implementation ZLXDataCacheTool
static FMDatabase *_db;
+ (void)initialize {
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/Data.db",NSHomeDirectory()];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_item (id integer PRIMARY KEY, itemDict blob NOT NULL, idStr text NOT NULL)"];
}
//存入数据库
+ (void)saveItemDict:(NSDictionary *)itemDict {
    //此处把字典归档成二进制数据直接存入数据库，避免添加过多的数据库字段
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:itemDict];
    [_db executeUpdateWithFormat:@"INSERT INTO t_item (itemDict, idStr) VALUES (%@, %@)",dictData, itemDict[@"id"]];
}
//返回全部数据
+ (NSArray *)list {
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_item"];
    NSMutableArray *list = [NSMutableArray array];
    while (set.next) {
        // 获得当前所指向的数据
        NSData *dictData = [set objectForColumnName:@"itemDict"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        [list addObject:[ZLXTopicModel mj_objectWithKeyValues:dict]];
    }
    return list;
}
//取出某个范围内的数据
+ (NSArray *)listWithRange:(NSRange)range {
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM t_item LIMIT %lu, %lu",range.location, range.length];
    FMResultSet *set = [_db executeQuery:SQL];
    NSMutableArray *list = [NSMutableArray array];
    while (set.next) {
        NSData *dictData = [set objectForColumnName:@"itemDict"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        [list addObject:[ZLXTopicModel mj_objectWithKeyValues:dict]];
    }
    return list;
}
//通过一组数据的唯一标识判断数据是否存在
+ (BOOL)isExistWithId:(NSString *)idStr
{
    BOOL isExist = NO;
    FMResultSet *resultSet= [_db executeQuery:@"SELECT * FROM t_item where idStr = ?",idStr];
    while ([resultSet next]) {
        if([resultSet stringForColumn:@"idStr"]) {
            isExist = YES;
        }else{
            isExist = NO;
        }
    }
    return isExist;
}
@end

