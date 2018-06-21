//
//  BaseViewController.m
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<STNavigationViewDelegate,GADBannerViewDelegate>

@property(copy,nonatomic)void(^onRightBtnClick)(void);
@property(strong, nonatomic)GADBannerView *bannerView;

@end

@implementation BaseViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    [self hideNavigationBar:YES];
    
}


-(void)hideNavigationBar : (Boolean) hidden{
    self.navigationController.navigationBarHidden = hidden;
}



-(void)setStatuBarBackgroud : (UIColor *)color{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


-(void)pushPage:(BaseViewController *)targetPage{
    [self.navigationController pushViewController:targetPage animated:YES];
}

-(void)backLastPage{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback{
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:needback];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
}

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback rightBtn:(NSString *)rightStr block:(void (^)(void))click{
    _onRightBtnClick = click;
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:needback rightBtn:rightStr];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
}

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback rightBtn:(NSString *)rightStr rightColor:(UIColor *)color block:(void (^)(void))click{
    _onRightBtnClick = click;
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:needback rightBtn:rightStr rightColor:color];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
}

-(void)OnBackBtnClicked{
    [self backLastPage];
}

-(void)onRightBtnClicked{
    _onRightBtnClick();
}


-(void)initAdmob{
    [self createBanner];
}

-(void)createBanner
{
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:@"450d43d2349f56a320138b0518b12c2195da2791", nil];
    
    _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    _bannerView.adUnitID = @"ca-app-pub-3441529924836552/8889032633";
    _bannerView.rootViewController = (id)self;
    _bannerView.backgroundColor = cwhite;
    _bannerView.delegate = (id<GADBannerViewDelegate>)self;
    _bannerView.frame = CGRectMake(0, ScreenHeight - STHeight(48), ScreenWidth , STHeight(48));
    [_bannerView loadRequest:request];
    
    [self.view addSubview:_bannerView];
}

//admob callback
/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}

-(void)removeAd{
    if(_bannerView){
        [_bannerView removeFromSuperview];
    }
}

@end
