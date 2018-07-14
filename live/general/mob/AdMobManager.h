//
//  AdMobManager.h
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdMobModel.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AdMobManager : NSObject
SINGLETON_DECLARATION(AdMobManager)

@property(strong, nonatomic)NSMutableArray *datas;

//初始化admob
-(void)initAdMob;

//添加banner广告
-(void)addBannerAd:(UIViewController *)controller;

//加载奖励广告
-(void)loadRewardAd;

//展示奖励广告
-(Boolean)showRewardAd:(UIViewController *)controller;

@end
