//
//  STObserverManager.m
//  framework
//
//  Created by 黄成实 on 2018/4/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STObserverManager.h"
#import "STObserver.h"
@interface STObserverManager()

@property(strong, nonatomic) NSMutableArray *obeservers;

@end

@implementation STObserverManager
SINGLETON_IMPLEMENTION(STObserverManager)


-(void)setup{
    if(_obeservers == nil){
        _obeservers = [[NSMutableArray alloc]init];
    }
}


-(void)registerSTObsever:(NSString *)key delegate:(id<STObserverProtocol>)delegate{
   if(_obeservers){
        STObserver *observer = [[STObserver alloc]init];
        observer.key = key;
        observer.statu = Default;
        observer.obseverDelegate = delegate;
        [observer addObserver:self forKeyPath:@"statu" options:NSKeyValueObservingOptionNew || NSKeyValueChangeOldKey context:nil];
        [_obeservers addObject:observer];
    }
}

-(void)removeSTObsever:(NSString *)key{
    if(!IS_NS_COLLECTION_EMPTY(_obeservers)){
        for(STObserver *observer in _obeservers){
            if([observer.key isEqualToString:key]){
                [_obeservers removeObject:observer];
                break;
            }
        }
    }
}

-(void)removeAll{
    [_obeservers removeAllObjects];
}


-(NSMutableArray *)getAllObsever{
    return _obeservers;
}


-(void)sendMessage:(NSString *)key msg:(id)message{
    if(!IS_NS_COLLECTION_EMPTY(_obeservers)){
        for(STObserver *observer in _obeservers){
            if([observer.key isEqualToString:key]){
                observer.message = message;
                //消息发送完毕，状态变为消息发送完成
                observer.statu = SendCompletion;
            }
        }
    }
}




-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"statu"]) {
        STObserver *obsever = (STObserver *)object;
        if(obsever && obsever.obseverDelegate && [obsever.obseverDelegate respondsToSelector:@selector(onReciveResult:msg:)]){
            //消息接收完毕，状态变成接收完成
            if(obsever.statu == SendCompletion){
                [obsever.obseverDelegate onReciveResult:obsever.key msg:obsever.message];
                obsever.statu = ReciveSendCompletion;
            }
        }
    }
}

@end
