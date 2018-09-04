//
//  AdMobManager.m
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AdMobManager.h"
#import "STObserverManager.h"
#import "STUserDefaults.h"

@interface AdMobManager()<GADRewardBasedVideoAdDelegate,GADBannerViewDelegate,GADInterstitialDelegate>

@property(strong, nonatomic)GADBannerView *bannerView;
@property(strong, nonatomic)GADInterstitial *interstitial;
@end

@implementation AdMobManager
SINGLETON_IMPLEMENTION(AdMobManager)

-(void)initAdMob{
    [GADMobileAds configureWithApplicationID:ADMOB_APPID];
    _rewardsDatas =[[NSMutableArray alloc]init];
    _fullScreenDatas = [[NSMutableArray alloc]init];
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    [self loadRewardAd];
    [self loadFullScreenAd];
}



/**banner广告**/

-(void)addBannerAd:(UIViewController *)controller{
    GADRequest *request = [GADRequest request];
//    request.testDevices = [NSArray arrayWithObjects:@"d1c9f8a00e166de5ed8af3510f69a6f1",@"68e48a1d27f25fe1e97fca434c75e5c6", nil];
    
    _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    _bannerView.adUnitID = AD_BANNER;
    _bannerView.rootViewController = (id)controller;
    _bannerView.backgroundColor = c01;
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
    NSLog(@"获取广告成功（banner广告）");
}

- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"获取广告失败（banner广告）");
}


- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"即将展示广告（插屏广告）");
}

- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"即将离开广告页（插屏广告）");
}

- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"已经离开广告页（banner广告）");
}


- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"离开APP（banner广告）");

}




/**插屏广告**/
-(void)loadFullScreenAd{
    _interstitial = [[GADInterstitial alloc]
                         initWithAdUnitID:AD_FULLSCREEN];
    _interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    [_interstitial loadRequest:request];
    
}

-(Boolean)showFullScreenAd:(UIViewController *)controller{
    if (_interstitial && _interstitial.isReady) {
        [_interstitial presentFromRootViewController:controller];
        return YES;
    }
    return NO;
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"获取广告成功（插屏广告）");
    [_fullScreenDatas addObject:ad];
}

- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"获取广告失败（插屏广告）");
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"即将展示广告（插屏广告）");
    if(!IS_NS_COLLECTION_EMPTY(_fullScreenDatas)){
        [_fullScreenDatas removeObject:ad];
    }
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"即将离开广告页（插屏广告）");
    AdMobModel *model = [[AdMobModel alloc]init];
    model.count = 10;
    model.type = @"B币";
    [self addRewards:model];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"已经离开广告页（插屏广告）");
}


- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"离开APP（插屏广告）");
}


/**rewards广告**/

-(void)loadRewardAd{
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request]
                                           withAdUnitID:AD_REWORD];
}

-(Boolean)showRewardAd:(UIViewController *)controller{
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:controller];
        return YES;
    }
    return NO;
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    AdMobModel *model = [[AdMobModel alloc]init];
    model.count = [reward.amount intValue];
    model.type = reward.type;
    [self addRewards:model];
    NSLog(@"接收奖励成功（激励广告）");
}



- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"打开广告（激励广告）");
    if(!IS_NS_COLLECTION_EMPTY(_rewardsDatas)){
        [_rewardsDatas removeObject:rewardBasedVideoAd];
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadRewardAd];
        [self loadFullScreenAd];
    });
    NSLog(@"获取广告失败（激励广告）");
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"获取广告成功（激励广告）");
    [_rewardsDatas addObject:rewardBasedVideoAd];
    [[STObserverManager sharedSTObserverManager]sendMessage:Notify_ADMOB msg:nil];
}

-(void)addRewards:(AdMobModel *)model{
    int bb = [[STUserDefaults getKeyValue:UD_BB] intValue];
    bb +=model.count;
    [STUserDefaults saveKeyValue:UD_BB value:[NSString stringWithFormat:@"%d",bb]];
    [[STObserverManager sharedSTObserverManager]sendMessage:Notify_Reward msg:model];
}

-(Boolean)showAd:(UIViewController *)controller{
    if(!IS_NS_COLLECTION_EMPTY(_rewardsDatas)){
        return [self showRewardAd:controller];
    }
    if(!IS_NS_COLLECTION_EMPTY(_fullScreenDatas)){
        return [self showFullScreenAd:controller];
    }
    return NO;
}

@end
