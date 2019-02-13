//
//  LoginPage.m
//  live
//
//  Created by 黄成实 on 2018/8/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "LoginPage.h"
#import "LoginView.h"
#import "MainPage.h"

@interface LoginPage ()<LoginDelegate>

@property(strong, nonatomic)LoginViewModel *mViewModel;
@property(strong, nonatomic)LoginView *mLoginView;

@end

@implementation LoginPage

+(void)show:(BaseViewController *)controller{
    LoginPage *page = [[LoginPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self initView];
}



-(void)initView{
    
    _mViewModel = [[LoginViewModel alloc]init];
    _mViewModel.delegate = self;
    
    _mLoginView = [[LoginView alloc]initWithViewModel:_mViewModel];
    _mLoginView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _mLoginView.backgroundColor = cbg;
    [self.view addSubview:_mLoginView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    });
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mLoginView onLoginCallback];
    if([respondModel.requestUrl containsString:URL_GETVERIFYCODE]){
        
    }else if([respondModel.requestUrl isEqualToString:URL_LOGIN]){
        [MainPage show:self];
    }
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mLoginView onLoginCallback];

}




////////
-(void)onWechatLogin:(Boolean)success msg:(NSString *)msg{
    if(!success){
        [STAlertUtil showAlertController:@"提示" content:msg controller:self];
    }
}

- (void)onTimeCount:(Boolean)complete{
    [_mLoginView updateVerifyBtn:complete];
}

@end
