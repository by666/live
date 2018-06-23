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
@interface MainPage ()<MainViewDelegate>

@property(strong, nonatomic)MainView *mainView;

@end

@implementation MainPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_MAIN_TITLE needback:NO];
    [self initView];
    [self initAdmob];
}

-(void)viewWillAppear:(BOOL)animated{ 
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setStatuBarBackgroud:c18];
}




-(void)initView{
    
    MainViewModel *viewModel = [[MainViewModel alloc]init];
    viewModel.delegate = self;

    
    _mainView = [[MainView alloc]initWithViewModel:viewModel];
    _mainView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_mainView];
}



-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    })
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showFailureAlertSheet:msg];
}


-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    if(_mainView){
        [_mainView updateView];
    }
}

-(void)onGoDetailPage:(MainModel *)mainModel{
    [DetailPage show:mainModel controller:self];
}

@end
