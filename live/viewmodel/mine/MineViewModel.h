//
//  MineViewModel.h
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MineViewDelegate

-(void)onOpenRewardAd;
-(void)onAddCoin;
-(void)onGoAgreementPage;
-(void)onGoAboutPage;
-(void)onGoDisclaimerPage;



@end

@interface MineViewModel : NSObject

@property(weak, nonatomic)id<MineViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
-(void)openRewardAd;
-(void)goAgreementPage;
-(void)goAboutPage;
-(void)goDisclaimerPage;
-(void)addCoin:(double)count;

@end
