//
//  AdMobManager.m
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AdMobManager.h"
#import "STObserverManager.h"

@interface AdMobManager()<GADRewardBasedVideoAdDelegate>

@end

@implementation AdMobManager
SINGLETON_IMPLEMENTION(AdMobManager)

-(void)initAdMob{
    [GADMobileAds configureWithApplicationID:ADMOB_APPID];
    _datas =[[NSMutableArray alloc]init];
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    [self loadRewardAd];
}


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
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    [_datas addObject:rewardBasedVideoAd];
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
    if(!IS_NS_COLLECTION_EMPTY(_datas)){
        [_datas removeObject:rewardBasedVideoAd];
        [self loadRewardAd];
    }
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
}

- (void)rewardBasedVideoAdDidCompletePlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad has completed.");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
}
@end
