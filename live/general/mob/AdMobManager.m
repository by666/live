//
//  AdMobManager.m
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AdMobManager.h"
#import "STObserverManager.h"

@interface AdMobManager()<GADRewardBasedVideoAdDelegate,GADBannerViewDelegate>

@property(strong, nonatomic)GADBannerView *bannerView;
@end

@implementation AdMobManager
SINGLETON_IMPLEMENTION(AdMobManager)

-(void)initAdMob{
    [GADMobileAds configureWithApplicationID:ADMOB_APPID];
    _datas =[[NSMutableArray alloc]init];
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    [self loadRewardAd];
}



/**banner广告**/

-(void)addBannerAd:(UIViewController *)controller{
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:@"d1c9f8a00e166de5ed8af3510f69a6f1",@"68e48a1d27f25fe1e97fca434c75e5c6", nil];
    
    _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    _bannerView.adUnitID = AD_BANNER;
    _bannerView.rootViewController = (id)controller;
    _bannerView.backgroundColor = c03;
    _bannerView.delegate = (id<GADBannerViewDelegate>)self;
    _bannerView.frame = CGRectMake(0, ScreenHeight - STHeight(48), ScreenWidth , STHeight(48));
    [_bannerView loadRequest:request];
    
    [controller.view addSubview:_bannerView];
}

-(void)removeBannerAd{
    if(_bannerView){
        [_bannerView removeFromSuperview];
    }
}



- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"获取banner广告成功");
}

- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"获取banner广告失败");
}


- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}


- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}



/**rewards广告**/

-(void)loadRewardAd{
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request]
                                           withAdUnitID:AD_REWORD];
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(IS_NS_COLLECTION_EMPTY(weakSelf.datas)){
            [weakSelf loadRewardAd];
        }
    });
}

-(void)showRewardAd:(UIViewController *)controller{
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:controller];
    }
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    AdMobModel *model = [[AdMobModel alloc]init];
    model.count = [reward.amount doubleValue];
    model.type = reward.type;
    [[STObserverManager sharedSTObserverManager]sendMessage:Notify_Reward msg:model];
    NSLog(@"接收奖励成功（激励广告）");

}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"获取广告成功（激励广告）");
    [_datas addObject:rewardBasedVideoAd];
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"打开广告（激励广告）");
    if(!IS_NS_COLLECTION_EMPTY(_datas)){
        [_datas removeObject:rewardBasedVideoAd];
        [self loadRewardAd];
    }
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"播放广告中（激励广告）");
}

- (void)rewardBasedVideoAdDidCompletePlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"播放广告完成（激励广告）");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"关闭广告（激励广告）");
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"离开APP（激励广告）");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"获取激励广告失败");
}
@end
