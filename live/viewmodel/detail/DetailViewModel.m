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
#import "GiftModel.h"
@interface DetailViewModel()

@property(strong, nonatomic)MainModel *mMainModel;
@property(assign, nonatomic)Boolean giftHidden;

@end
@implementation DetailViewModel

-(instancetype)initWithMainModel:(MainModel *)mainModel{
    if(self == [super init]){
        _giftHidden = YES;
        _mMainModel = mainModel;
        _detailModel = [[DetailModel alloc]init];
        _chatDatas = [[NSMutableArray alloc]init];
        _giftDatas = [[NSMutableArray alloc]init];
        [self buildChatDatas];
        [self buildGiftDatas];
    }
    return self;
}


-(void)buildChatDatas{
    [_chatDatas addObject:[ChatModel buildModel:1L name:MSG_CHAT_SYSTEM content:MSG_CHAT_SYSTEM_MSG identify:CI_System]];
    [_chatDatas addObject:[ChatModel buildModel:2L name:@"邻家小哥哥" content:@"666" identify:CI_User]];
    [_chatDatas addObject:[ChatModel buildModel:3L name:@"by" content:@"送出一个飞吻 x 1" identify:CI_Mine]];
    [_chatDatas addObject:[ChatModel buildModel:4L name:@"夜太美" content:@"主播唱的好听" identify:CI_User]];

}

-(void)buildGiftDatas{
    [_giftDatas addObject:[GiftModel buildModel:@"1" url:@"www" price:10]];
    [_giftDatas addObject:[GiftModel buildModel:@"2" url:@"www" price:20]];
    [_giftDatas addObject:[GiftModel buildModel:@"3" url:@"www" price:30]];
    [_giftDatas addObject:[GiftModel buildModel:@"4" url:@"www" price:40]];
    [_giftDatas addObject:[GiftModel buildModel:@"5" url:@"www" price:50]];
    [_giftDatas addObject:[GiftModel buildModel:@"6" url:@"www" price:60]];
    
    [_giftDatas addObject:[GiftModel buildModel:@"1" url:@"www" price:10]];
    [_giftDatas addObject:[GiftModel buildModel:@"2" url:@"www" price:20]];
    [_giftDatas addObject:[GiftModel buildModel:@"3" url:@"www" price:30]];
    [_giftDatas addObject:[GiftModel buildModel:@"4" url:@"www" price:40]];
    [_giftDatas addObject:[GiftModel buildModel:@"5" url:@"www" price:50]];
    [_giftDatas addObject:[GiftModel buildModel:@"6" url:@"www" price:60]];
    
    [_giftDatas addObject:[GiftModel buildModel:@"1" url:@"www" price:10]];
    [_giftDatas addObject:[GiftModel buildModel:@"2" url:@"www" price:20]];
    [_giftDatas addObject:[GiftModel buildModel:@"3" url:@"www" price:30]];
    [_giftDatas addObject:[GiftModel buildModel:@"4" url:@"www" price:40]];
    [_giftDatas addObject:[GiftModel buildModel:@"5" url:@"www" price:50]];

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


-(void)hideGiftView:(Boolean)hidden{
    if(_delegate){
        _giftHidden = hidden;
        [_delegate onHideGiftView:hidden];
    }
}
@end
