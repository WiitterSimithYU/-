//
//  ZLXCacheTool.m
//  真有趣
//
//  Created by zlx on 2017/3/26.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXCacheTool.h"
#import "FMDB.h"
#import "ZLXTopicModel.h"

@implementation ZLXCacheTool
/** 数据库实例 */
static FMDatabaseQueue *_queue ;
+ (void) initialize{/** 1490512021
                                1490512021
                                1490512021*/
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"ZLXLZTHome.sqlite"];
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    NSLog(@"%@",path);
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS ZLXLZT_Home_Status (id integer PRIMARY KEY AUTOINCREMENT, ZLX_id text NOT NULL, ZLX_dict blob NOT NULL);"];
    }];
}
/** 存的是字典数组*/
+ (void) ZLX_addStatuses:(NSArray *)dictArray{
    for (NSDictionary *dic in dictArray) {
        [self addStatus:dic];
    }
}
+ (void) addStatus:(NSDictionary *)dict{
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *ID = dict[@"id"] ;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [db executeUpdate:@"insert into ZLXLZT_Home_Status (ZLX_id,ZLX_dict)VALUES(?,?)",ID,data];
    }];
    
}
/** 读取缓存数据*/
+ (NSArray *) ReadCache{
    NSMutableArray *Marray = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {/** page maxid since_id*/
     FMResultSet *result =  [db executeQuery:@"select * FROM ZLXLZT_Home_Status;"];
        //遍历结果集
        while (result.next) {
            NSData *data = [result dataForColumn:@"ZLX_dict"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            NSLog(@"在此处打印json数据%@",dict);
            //字典转模型
            ZLXTopicModel *model = [ZLXTopicModel mj_objectWithKeyValues:dict];
            [Marray addObject:model];
        }
    }];
    return Marray;
}
-(NSString*)getJsonStr:(NSDictionary*)dict{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}
@end
