//
//  MainPage.m
//  live
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainPage.h"
#import "MainView.h"

@interface MainPage ()<MainViewDelegate>

@property(strong, nonatomic)MainView *mainView;

@end

@implementation MainPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_SCHEDULE_TITLE needback:NO];
    [self initView];
    [self initAdmob];
}

-(void)viewWillAppear:(BOOL)animated{ 
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setStatuBarBackgroud:c03];
}




-(void)initView{
    
    MainViewModel *viewModel = [[MainViewModel alloc]init];
    viewModel.delegate = self;

    
    _mainView = [[MainView alloc]initWithViewModel:viewModel];
    _mainView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_mainView];
}


-(void)onRequestCallback:(Boolean)success errorMsg:(NSString *)errorMsg{
    if(_mainView){
        [_mainView updateScheduleView];
    }
}


-(void)onChangeTab:(NSInteger)index{
    if(index == 0){
        [self.navigationView setTitle:MSG_INFO_TITLE];
    }else{
        [self.navigationView setTitle:MSG_SCHEDULE_TITLE];
    }
}

@end
