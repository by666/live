//
//  DetailViewModel.m
//  live
//
//  Created by by.huang on 2018/6/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DetailViewModel.h"
#import "STNetUtil.h"
#import "ChatModel.h"
@interface DetailViewModel()


@property(strong, nonatomic)MainModel *mMainModel;

@end
@implementation DetailViewModel

-(instancetype)initWithMainModel:(MainModel *)mainModel{
    if(self == [super init]){
        _mMainModel = mainModel;
        _detailModel = [[DetailModel alloc]init];
        _chatDatas = [[NSMutableArray alloc]init];
        [self buildChatDatas];
    }
    return self;
}


-(void)buildChatDatas{
    [_chatDatas addObject:[ChatModel buildModel:1L name:MSG_CHAT_SYSTEM content:MSG_CHAT_SYSTEM_MSG identify:CI_System]];
    [_chatDatas addObject:[ChatModel buildModel:2L name:@"邻家小哥哥" content:@"666" identify:CI_User]];
    [_chatDatas addObject:[ChatModel buildModel:3L name:@"by" content:@"送出一个飞吻 x 1" identify:CI_Mine]];
    [_chatDatas addObject:[ChatModel buildModel:4L name:@"夜太美" content:@"主播唱的好听" identify:CI_User]];

}

-(void)requestData{
    if(_delegate){
        [_delegate onRequestBegin];
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//        dic[@"room_id"] = [NSString stringWithFormat:@"%ld",_mMainModel.room_id];
//        dic[@"origin"] = _mMainModel.origin;
        NSString *url = [NSString stringWithFormat:@"%@?room_id=%ld&origin=%@",URL_LIVE_DETAIL,_mMainModel.room_id,_mMainModel.origin];
        WS(weakSelf)
        [STNetUtil get:url parameters:nil success:^(RespondModel *respondModel) {
            if(respondModel.code == 200){
                weakSelf.detailModel = [DetailModel mj_objectWithKeyValues:respondModel.data];
                [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.detailModel];
            }else{
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}

-(void)useroffline{
    if(_delegate){
        [_delegate onUserOffline];
    }
}

-(void)showNavigationBar{
    if(_delegate){
        [_delegate onShowNavigationBar];
    }
}


-(void)report{
    if(_delegate){
        [_delegate onReportResult];
    }
}
@end
