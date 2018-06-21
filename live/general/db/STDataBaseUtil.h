//
//  STDataBaseUtil.h
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface STDataBaseUtil : NSObject
SINGLETON_DECLARATION(STDataBaseUtil)

//建表
-(void)createTable:(NSString *)tableName model:(id)model;

//插入一行数据源
-(void)insertRow:(NSString *)tableName model:(id)model;

//删除一行数据
-(void)deleteRow:(NSString *)tableName cid:(NSString *)cid;

//删除所有数据
-(void)deletaAll:(NSString *)tableName;

//查找一条数据
-(id)queryRow:(NSString *)tableName cid:(NSString *)cid model:(id)model;

//查找所有数据
-(NSMutableArray *)queryAll:(NSString *)tableName model:(id)model;

//修改一条数据
-(void)updateRow:(NSString *)tableName cid:(NSString *)cid model:(id)model;


@end
