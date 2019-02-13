//
//  HomeViewModel.m
//  live
//
//  Created by by.huang on 2019/2/13.
//  Copyright © 2019 黄成实. All rights reserved.
//

#import "HomeViewModel.h"
#import "MainModel.h"
#import "STNetUtil.h"

@implementation HomeViewModel

    
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
