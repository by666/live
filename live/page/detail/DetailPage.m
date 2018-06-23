//
//  DetailPage.m
//  live
//
//  Created by by.huang on 2018/6/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DetailPage.h"
#import "DetailView.h"
#import "STToastUtil.h"
@interface DetailPage ()<DetailViewDelegate>

@property(strong, nonatomic)MainModel *mMainModel;
@property(strong, nonatomic)DetailView *detailView;

@end

@implementation DetailPage


+(void)show:(MainModel *)mainModel controller:(BaseViewController *)controller{
    DetailPage *page = [[DetailPage alloc]init];
    page.mMainModel = mainModel;
    [controller pushPage:page];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:_mMainModel.nick needback:YES];
    self.view.backgroundColor = cwhite;
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setStatuBarBackgroud:c18];
}


-(void)initView{
    DetailViewModel *viewModel = [[DetailViewModel alloc]initWithMainModel:_mMainModel];
    viewModel.delegate = self;
    
    _detailView = [[DetailView alloc]initWithViewModel:viewModel];
    _detailView.frame = CGRectMake(0,StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _detailView.backgroundColor = cwhite;
    [self.view addSubview:_detailView];
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
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if(_detailView){
        [_detailView updateView];
    }
}


-(void)backLastPage{
    if(_detailView){
        [_detailView removeView];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end