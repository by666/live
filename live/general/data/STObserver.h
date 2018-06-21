//
//  STObserver.h
//  framework
//
//  Created by 黄成实 on 2018/4/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

//消息发送状态
typedef NS_ENUM(NSInteger,ObserverStatu){
    Default = 0,           //默认
    SendCompletion,        //发送完毕
    ReciveSendCompletion   //接收完毕
};

@protocol STObserverProtocol

-(void)onReciveResult:(NSString *)key msg:(id)msg;

@end


@interface STObserver : NSObject

@property(copy,nonatomic) NSString *key;
@property(assign,nonatomic) NSInteger statu;
@property(strong,nonatomic) id message;
@property(weak,nonatomic) id obseverDelegate;

@end
