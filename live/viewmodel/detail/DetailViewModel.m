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
}

-(void)buildGiftDatas{

    [_giftDatas addObject:[GiftModel buildModel:@"丘比特" url:@"http://xkaoss.huyanzu.com/public/attachment/201805/26/07/5b08a17b901ba.png?x-oss-process=image/resize,m_mfit,h_260,w_260/resize,m_mfit,h_260,w_260" price:10]];
    [_giftDatas addObject:[GiftModel buildModel:@"法拉利" url:@"http://xkaoss.huyanzu.com/public/attachment/201805/26/05/5b0883cdd9644.png?x-oss-process=image/resize,m_mfit,h_260,w_260/resize,m_mfit,h_260,w_260" price:50]];
    [_giftDatas addObject:[GiftModel buildModel:@"轰炸机" url:@"http://xkaoss.huyanzu.com/public/attachment/201805/26/05/5b08844162f34.png?x-oss-process=image/resize,m_mfit,h_260,w_260/resize,m_mfit,h_260,w_260" price:100]];
    [_giftDatas addObject:[GiftModel buildModel:@"客机" url:@"http://xkaoss.huyanzu.com/public/attachment/201805/26/05/5b088415ea55d.png?x-oss-process=image/resize,m_mfit,h_260,w_260/resize,m_mfit,h_260,w_260" price:100]];
    [_giftDatas addObject:[GiftModel buildModel:@"火箭" url:@"http://xkaoss.huyanzu.com/public/attachment/201805/26/05/5b08842a87c51.png?x-oss-process=image/resize,m_mfit,h_260,w_260/resize,m_mfit,h_260,w_260" price:1000]];

}

-(void)requestData{
    if(_delegate){
        [_delegate onRequestBegin];
        NSString *url = @"";
        WS(weakSelf)
        [STNetUtil get:url parameters:nil success:^(RespondModel *respondModel) {
            if(respondModel.code == CODE_SUCCESS){
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

-(void)sendGift:(GiftModel *)giftModel{
    [_chatDatas addObject:[ChatModel buildModel:3L name:@"by" content:[NSString stringWithFormat:@"送出一个%@ x 1",giftModel.giftName] identify:CI_Mine]];
    if(_delegate){
        [_delegate onUpdateChatView];
    }
}

-(void)openChat{
    if(_delegate){
        [_delegate onOpenChat];
    }
}
@end
