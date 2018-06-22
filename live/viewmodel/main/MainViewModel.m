//
//  MainViewModel.m
//  live
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainViewModel.h"
#import "STNetUtil.h"
#import "MainModel.h"
@implementation MainViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)requestData{
    if(_delegate){
        [_delegate onRequestBegin];
        
        WS(weakSelf)
        [STNetUtil get:URL_LIVE_LIST parameters:nil success:^(RespondModel *respondModel) {
            weakSelf.datas = [MainModel mj_objectArrayWithKeyValuesArray:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.datas];
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}


@end
