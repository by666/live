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
#import "HomeView.h"
@interface MainPage ()<STTabBarViewDelegate,HomeViewDelegate>

@property(strong, nonatomic)UIView *contentView;
@property(strong, nonatomic)id currentView;
@property(strong, nonatomic)STTabBarView *tabBarView;
@property(strong, nonatomic)HomeView *homeView;

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
    _tabBarView = [[STTabBarView alloc]initWithTitles:titles centerBtn:YES];
    _tabBarView.delegate = self;
    [self.view addSubview:_tabBarView];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _contentView.backgroundColor = cblack;
    [self.view addSubview:_contentView];

    [_contentView addSubview:[self homeView]];
    [_tabBarView setTabBarTransparent:YES];
    
    [self.view bringSubviewToFront:_tabBarView];
}


-(HomeView *)homeView{
    if(_homeView == nil){
        HomeViewModel *homeVM = [[HomeViewModel alloc]init];
        homeVM.delegate = self;
        _homeView = [[HomeView alloc]initWithViewModel:homeVM];
        _homeView.frame = _contentView.frame;
    }
    return _homeView;
}

-(void)onTabBarSelected:(NSInteger)index{
    if(index == 0){
        [_tabBarView setTabBarTransparent:YES];
    }else{
        [_tabBarView setTabBarTransparent:NO];
    }
}



-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    
}

-(void)onRequestFail:(NSString *)msg{
    
}


@end
