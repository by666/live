//
//  STObserverManager.h
//  framework
//
//  Created by 黄成实 on 2018/4/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STObserver.h"


@interface STObserverManager : NSObject
SINGLETON_DECLARATION(STObserverManager)

//初始化观察者队列
-(void)setup;

//注册观察者广播
-(void)registerSTObsever:(NSString *)key delegate:(id<STObserverProtocol>)delegate;

//移除观察者广播
-(void)removeSTObsever:(NSString *)key;

//移除所有观察者
-(void)removeAll;

//获取所有观察者
-(NSMutableArray*)getAllObsever;

//广播消息
-(void)sendMessage:(NSString *)key msg:(id)message;


@end
