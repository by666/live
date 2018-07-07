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
@interface DetailPage ()<DetailViewDelegate>

@property(strong, nonatomic)MainModel *mMainModel;
@property(strong, nonatomic)DetailView *detailView;
@property(strong, nonatomic)GiftView *giftView;

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
    [[AdMobManager sharedAdMobManager] loadRewardAd];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setStatuBarBackgroud:c18];
}



-(void)initView{
    DetailViewModel *viewModel = [[DetailViewModel alloc]initWithMainModel:_mMainModel];
    viewModel.delegate = self;
    
    _detailView = [[DetailView alloc]initWithViewModel:viewModel];
    _detailView.frame = CGRectMake(0,0, ScreenWidth, ScreenHeight);
    _detailView.backgroundColor = cwhite;
    [self.view addSubview:_detailView];
    
    _giftView = [[GiftView alloc]initWithDatas:viewModel.giftDatas];
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
@end
