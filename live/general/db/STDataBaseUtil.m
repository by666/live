//
//  STDataBaseUtil.m
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STDataBaseUtil.h"
#import "STRuntimeUtil.h"
@interface STDataBaseUtil()

@end

@implementation STDataBaseUtil
SINGLETON_IMPLEMENTION(STDataBaseUtil)

-(FMDatabaseQueue *)getFMDatabaseQueue{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"st.sqlite"];
    return [FMDatabaseQueue databaseQueueWithPath:filename];
}

-(void)createTable:(NSString *)tableName model:(id)model{
    NSArray *array = [STRuntimeUtil getAllPropertyNames:model];
    NSString *sqlStr;
    @autoreleasepool{
        if(!IS_NS_COLLECTION_EMPTY(array)){
            sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT",tableName];
            for(NSString *key in array){
                sqlStr = [sqlStr stringByAppendingString:[NSString stringWithFormat:@", %@ text NOT NULL",key]];
            }
            sqlStr = [sqlStr stringByAppendingString:@");"];
        }
    }
    FMDatabaseQueue *queue = [self getFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            BOOL result = [db executeUpdate:sqlStr];
            if (result) {
                [STLog print:@"create table success"];
            } else {
                [STLog print:@"create table fail"];
            }
        }
    }];
}


-(void)insertRow:(NSString *)tableName model:(id)model{
    NSArray *array = [STRuntimeUtil getAllPropertyNames:model];
    NSMutableArray *valueArray = [[NSMutableArray alloc]init];
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (",tableName];
    @autoreleasepool{
        if(!IS_NS_COLLECTION_EMPTY(array)){
            for(NSString *key in array){
                sqlStr = [sqlStr stringByAppendingString:key];
                sqlStr =[sqlStr stringByAppendingString:@","];
                NSString *value = [STRuntimeUtil getPropertyValue:model key:key];
                if(IS_NS_STRING_EMPTY(value)){
                    value = @"";
                }
                [valueArray addObject:value];
            }
            sqlStr = [sqlStr substringToIndex:sqlStr.length - 1];
            sqlStr = [sqlStr stringByAppendingString:@") VALUES ("];
            for(int i= 0 ; i< [array count] ; i ++){
                sqlStr = [sqlStr stringByAppendingString:@"?,"];
            }
            sqlStr = [sqlStr substringToIndex:sqlStr.length - 1];
            sqlStr = [sqlStr stringByAppendingString:@");"];
        }
    }
  
    FMDatabaseQueue *queue = [self getFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        Boolean result = [db executeUpdate:sqlStr withArgumentsInArray:valueArray];
        if(result){
            [STLog print:@"insert a row success"];
        }else{
            [STLog print:@"insert a row fail"];
        }
        [db commit];
    }];
}


-(void)deleteRow:(NSString *)tableName cid:(NSString *)cid{
    FMDatabaseQueue *queue = [self getFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        Boolean result = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE cid=%@",tableName,cid]];
        if(result){
            [STLog print:@"delete a row success"];
        }else{
            [STLog print:@"delete a row fail"];
        }
        [db commit];
    }];
}


-(void)deletaAll:(NSString *)tableName{
    FMDatabaseQueue *queue = [self getFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        Boolean result = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",tableName]];
        if(result){
            [STLog print:@"delete all row success"];
        }else{
            [STLog print:@"delete all row fail"];
        }
        [db commit];
    }];
}

-(id)queryRow:(NSString *)tableName cid:(NSString *)cid model:(id)model{
    NSArray *array = [STRuntimeUtil getAllPropertyNames:model];
    FMDatabaseQueue *queue = [self getFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        FMResultSet *resultSet = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE cid=%@",tableName,cid]];
        //method 2 : get all keys
//        NSMutableDictionary *dic = [resultSet columnNameToIndexMap];
//        NSArray *keys = [dic allKeys];
        while ([resultSet next]){
            if(!IS_NS_COLLECTION_EMPTY(array))
            for(NSString *key in array){
                NSString *value = [resultSet objectForColumn:key];
                [model setValue:value forKey:key];
            }
        }
        [db commit];
    }];
    return model;
}


-(NSMutableArray *)queryAll:(NSString *)tableName model:(id)model{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    NSArray *array = [STRuntimeUtil getAllPropertyNames:model];
    FMDatabaseQueue *queue = [self getFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        @autoreleasepool{
            FMResultSet *resultSet = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableName]];
            while ([resultSet next]){
                NSMutableDictionary *tempModel = [[NSMutableDictionary alloc]init];
                if(!IS_NS_COLLECTION_EMPTY(array)){
                    for(NSString *key in array){
                        NSString *value = [resultSet objectForColumn:key];
                        [tempModel setValue:value forKey:key];
                    }
                    [datas addObject:tempModel];
                }
            }
        }
        [db commit];
    }];
    return datas;
}


-(void)updateRow:(NSString *)tableName cid:(NSString *)cid model:(id)model{
    NSArray *array = [STRuntimeUtil getAllPropertyNames:model];
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE %@ SET ",tableName];
    for(NSString *key in array){
        NSString *value = [STRuntimeUtil getPropertyValue:model key:key];
        sqlStr = [sqlStr stringByAppendingString:[NSString stringWithFormat:@"%@ = '%@' ,",key,value]];
    }
    sqlStr = [sqlStr substringToIndex:sqlStr.length - 1];
    sqlStr = [sqlStr stringByAppendingString:[NSString stringWithFormat:@" WHERE cid = '%@'",cid]];
    FMDatabaseQueue *queue = [self getFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        Boolean result = [db executeUpdate:sqlStr];
        if(result){
            [STLog print:@"update a row success"];
        }else{
            [STLog print:@"update a row fail"];
        }
        [db commit];
    }];
}

@end
