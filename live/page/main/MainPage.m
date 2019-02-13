//
//  MainPage.m
//  live
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainPage.h"
#import "MainView.h"
#import "STToastUtil.h"
#import "DetailPage.h"
#import "MinePage.h"
#import "STTabBarView.h"
#import "AdMobManager.h"
@interface MainPage ()<STTabBarViewDelegate>

@end

@implementation MainPage

+(void)show:(BaseViewController *)controller{
    MainPage *page = [[MainPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{ 
    [super viewWillAppear:animated];
}




-(void)initView{
    NSArray *titles = @[MSG_HOME_TITLE,MSG_FOLLOW_TITLE,MSG_MSG_TITLE,MSG_MINE_TITLE];
    STTabBarView *tabbarView = [[STTabBarView alloc]initWithTitles:titles centerBtn:YES];
    tabbarView.delegate = self;
    [self.view addSubview:tabbarView];
}

-(void)onTabBarSelected:(NSInteger)index{
    
}



@end
