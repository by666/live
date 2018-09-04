//
//  DetailPage.m
//  live
//
//  Created by by.huang on 2018/6/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DetailPage.h"
#import "DetailView.h"
#import "STToastUtil.h"
#import "AdMobManager.h"
#import "STNetUtil.h"
#import "GiftView.h"
#import "STUserDefaults.h"
#import "MinePage.h"
@interface DetailPage ()<DetailViewDelegate,GiftViewDelegate>

@property(strong, nonatomic)MainModel *mMainModel;
@property(strong, nonatomic)DetailView *detailView;
@property(strong, nonatomic)GiftView *giftView;
@property(strong, nonatomic)DetailViewModel *viewModel;

@end

@implementation DetailPage


+(void)show:(MainModel *)mainModel controller:(BaseViewController *)controller{
    DetailPage *page = [[DetailPage alloc]init];
    page.mMainModel = mainModel;
    [controller pushPage:page];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self initView];

}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setStatuBarBackgroud:c01];
}



-(void)initView{
    _viewModel = [[DetailViewModel alloc]initWithMainModel:_mMainModel];
    _viewModel.delegate = self;
    
    _detailView = [[DetailView alloc]initWithViewModel:_viewModel];
    _detailView.frame = CGRectMake(0,0, ScreenWidth, ScreenHeight);
    _detailView.backgroundColor = cwhite;
    [self.view addSubview:_detailView];
    
    _giftView = [[GiftView alloc]initWithDatas:_viewModel.giftDatas];
    _giftView.delegate = self;
    [self.view addSubview:_giftView];

}

-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    })
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showFailureAlertSheet:msg];
}


-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if(_detailView){
        [_detailView updateView];
    }
}


-(void)backLastPage{
    if(_detailView){
        [_detailView removeView];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)onUserOffline{
    WS(weakSelf)
    [STAlertUtil showAlertController:MSG_PROMPT content:MSG_LIVE_FAIL controller:self confirm:^{
        [weakSelf backLastPage];
    }];
}

-(void)onShowNavigationBar{
    [self showSTNavigationBar:_mMainModel.nick needback:YES backgroudColor:[UIColor clearColor]];
}

-(void)onReportResult{
    if(![STNetUtil getNetStatu]){
        [STToastUtil showFailureAlertSheet:MSG_NET_ERROR];
        return;
    }
    WS(weakSelf)
    [STAlertUtil showAlertController:MSG_REPORT_TITLE content:MSG_REPORT_CONTENT controller:self confirm:^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [STToastUtil showSuccessTips:MSG_REPORT_SUCCESS];
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        });
    }];
}


-(void)onHideGiftView:(Boolean)hidden{
    if(_giftView){
        [_giftView hideGiftView:hidden];
    }
}

-(void)onSelectItem:(GiftModel *)giftModel{
    [self onHideGiftView:YES];
    int bb = [[STUserDefaults getKeyValue:UD_BB] intValue];
    if(bb < giftModel.giftPrice){
        WS(weakSelf)
        [STAlertUtil showAlertController:@"哎呀~" content:@"您的B币余额不足，是否现在就去观看广告免费赚取B币？" controller:self confirm:^{
            [MinePage show:weakSelf];
        }];
    }else{
        bb = bb - giftModel.giftPrice;
        [STUserDefaults saveKeyValue:UD_BB value:[NSString stringWithFormat:@"%d",bb]];
        if(_viewModel){
            [_viewModel sendGift:giftModel];
        }
    }
}

-(void)onUpdateChatView{
    if(_detailView){
        [_detailView updateChatView];
    }
}

-(void)onOpenChat{
    int bb = [[STUserDefaults getKeyValue:UD_BB] intValue];
    if(bb < 500){
        WS(weakSelf)
        [STAlertUtil showAlertController:@"哎呀~" content:@"永久开通聊天功能，需要花费500B币，是否现在就去观看广告免费赚取B币?" controller:self confirm:^{
            [MinePage show:weakSelf];
        }];
    }
}

@end
