//
//  MineViewModel.m
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MineViewModel.h"
#import "TitleContentModel.h"

@interface MineViewModel()

@property(assign, nonatomic)int coins;

@end
@implementation MineViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [self buildDatas];
    }
    return self;
}

-(void)buildDatas{
    NSArray *titleArray = @[@"免费获得C币",@"用户协议",@"免责声明",@"关于"];
    NSArray *contentArray = @[@"C币：0",@"",@"",@"v1.0"];
    for(int i= 0 ; i < titleArray.count ; i ++ ){
        [_datas addObject:[TitleContentModel buildModel:[titleArray objectAtIndex:i] content:[contentArray objectAtIndex:i]]];
    }
}

-(void)goAboutPage{
    if(_delegate){
        [_delegate onGoAboutPage];
    }
}

-(void)goAgreementPage{
    if(_delegate){
        [_delegate onGoAgreementPage];
    }
}

-(void)goDisclaimerPage{
    if(_delegate){
        [_delegate onGoDisclaimerPage];
    }
}

-(void)openRewardAd{
    if(_delegate){
        [_delegate onOpenRewardAd];
    }
}


-(void)addCoin:(double)count{
    _coins += count;
    if(_delegate){
        TitleContentModel *model = [_datas objectAtIndex:0];
        model.content = [NSString stringWithFormat:@"C币：%d",_coins];
        [_delegate onAddCoin];
    }
}



@end
