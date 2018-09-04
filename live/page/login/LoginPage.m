//
//  LoginPage.m
//  live
//
//  Created by 黄成实 on 2018/8/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "LoginPage.h"
#import "LoginView.h"

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
    [STColorUtil setGradientColor:self.view startColor:c01 endColor:c02 director:Top];
    
    [self initView];
}



-(void)initView{
    
    _mViewModel = [[LoginViewModel alloc]init];
    _mViewModel.delegate = self;
    
    _mLoginView = [[LoginView alloc]initWithViewModel:_mViewModel];
    _mLoginView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:_mLoginView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setStatuBarBackgroud:c01];
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
    if([respondModel.requestUrl isEqualToString:URL_GETVERIFYCODE]){
        NSString *phoneNum = data;
    }else if([respondModel.requestUrl isEqualToString:URL_LOGIN]){
//        [MainPage show:self];
    }else if([respondModel.requestUrl isEqualToString:URL_WX_LOGIN]){
//        if([data isEqualToString:MSG_SUCCESS]){
//            [MainPage show:self];
//        }else{
//            [BindPhonePage show:self wxToken:data];
//        }
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
