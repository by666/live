//
//  BaseViewController.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STNavigationView.h"
@interface BaseViewController : UIViewController

@property(strong, nonatomic)STNavigationView *navigationView;

//隐藏导航栏
-(void)hideNavigationBar : (Boolean) hidden;

//设置状态栏背景色
-(void)setStatuBarBackgroud : (UIColor *)color;

//push viewcontroller
-(void)pushPage : (BaseViewController *)targetPage;

-(void)backLastPage;

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback;

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback rightBtn:(NSString *)rightStr block:(void (^)(void))click;

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback rightBtn:(NSString *)rightStr rightColor:(UIColor *)color block:(void (^)(void))click;

-(void)initAdmob;
-(void)removeAd;

@end
