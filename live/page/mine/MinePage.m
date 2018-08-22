//
//  MinePage.m
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MinePage.h"
#import "MineView.h"
#import "AboutPage.h"
#import "AgreementPage.h"
#import "DisclaimerPage.h"
#import "AdMobManager.h"
#import "STObserverManager.h"
#import "STToastUtil.h"

@interface MinePage ()<MineViewDelegate,STObserverProtocol>

@property(strong, nonatomic)MineView *mineView;
@property(strong, nonatomic)MineViewModel *viewModel;


@end

@implementation MinePage

+(void)show:(BaseViewController *)controller{
    MinePage *page = [[MinePage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_MINE_TITLE needback:YES];
    [self initView];
    [[STObserverManager sharedSTObserverManager]registerSTObsever:Notify_Reward delegate:self];

}


-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_Reward];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setStatuBarBackgroud:c18];
}

-(void)initView{
    _viewModel = [[MineViewModel alloc]init];
    _viewModel.delegate = self;
    
    _mineView = [[MineView alloc]initWithViewModel:_viewModel];
    _mineView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _mineView.backgroundColor = c01;
    [self.view addSubview:_mineView];
}


-(void)onGoAgreementPage{
    [AgreementPage show:self];
}

-(void)onGoAboutPage{
    [AboutPage show:self];
}

-(void)onGoDisclaimerPage{
    [DisclaimerPage show:self];
}

-(void)onOpenRewardAd{
    Boolean success = [[AdMobManager sharedAdMobManager] showAd:self];
    if(!success){
        [STToastUtil showFailureAlertSheet:@"很抱歉，广告未加载完毕，请过一会再来赚取B币"];
    }
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if(_viewModel && [key isEqualToString:Notify_Reward]){
        [_viewModel updateCoins];
    }
}

-(void)onUpdateCoins{
    if(_mineView){
        [_mineView updateView];
    }
}
@end
