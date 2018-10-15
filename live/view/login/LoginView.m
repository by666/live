//
//  LoginView.m
//  live
//
//  Created by 黄成实 on 2018/8/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "LoginView.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "STNavigationView.h"
#import "AccountManager.h"

@interface LoginView()

@property(strong, nonatomic) LoginViewModel *mViewModel;

@property(strong, nonatomic) UIButton *loginBtn;
@property(strong, nonatomic) UIButton *wechatLoginBtn;


@property(strong, nonatomic) UITextField *phoneNumTF;
@property(strong, nonatomic) UITextField *verifyCodeTF;
@property(strong, nonatomic) UIButton *sendVerifyCodeBtn;
@property(strong, nonatomic) UILabel *tipLabel;



@end

@implementation LoginView

-(instancetype)initWithViewModel:(LoginViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UILabel *loginLabel = [[UILabel alloc]initWithFont:STFont(30) text:MSG_LOGINVIEW_TITLE textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    loginLabel.frame = CGRectMake(0, STHeight(120), ScreenWidth, STHeight(30));
    [self addSubview:loginLabel];
    
    _phoneNumTF = [[UITextField alloc]initWithFont:STFont(16) textColor:cwhite backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:STWidth(2)];
    _phoneNumTF.frame =  CGRectMake(STWidth(47), STHeight(216), STWidth(280), STHeight(41));
    _phoneNumTF.keyboardType = UIKeyboardTypePhonePad;
    _phoneNumTF.text = [[AccountManager sharedAccountManager]getUserModel].phone;
    NSAttributedString *phoneNumStr = [[NSAttributedString alloc] initWithString:MSG_LOGIN_PHONENUM_HINT attributes:
                                       @{NSForegroundColorAttributeName:[cwhite colorWithAlphaComponent:0.5f],
                                         NSFontAttributeName:_phoneNumTF.font
                                         }];
    [_phoneNumTF setMaxLength:@"11"];
    _phoneNumTF.attributedPlaceholder = phoneNumStr;
    [_phoneNumTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_phoneNumTF];
    
    UIView *phoneLine = [[UIView alloc]init];
    phoneLine.backgroundColor = cwhite;
    phoneLine.frame = CGRectMake(STWidth(47), STHeight(257), STWidth(280), 0.5f);
    [self addSubview:phoneLine];
    
    _verifyCodeTF = [[UITextField alloc]initWithFont:STFont(16) textColor:cwhite backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:STWidth(2)];
    _verifyCodeTF.frame =  CGRectMake(STWidth(47), STHeight(273), STWidth(280), STHeight(41));
    _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    NSAttributedString *verifyCodeStr = [[NSAttributedString alloc] initWithString:MSG_LOGIN_VERIFYCODE_HINT attributes:
                                         @{NSForegroundColorAttributeName:[cwhite colorWithAlphaComponent:0.5f],
                                           NSFontAttributeName:_verifyCodeTF.font
                                           }];
    [_verifyCodeTF setMaxLength:@"6"];
    _verifyCodeTF.attributedPlaceholder = verifyCodeStr;
    [_verifyCodeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_verifyCodeTF];
    
    UIView *verifyLine = [[UIView alloc]init];
    verifyLine.backgroundColor = cwhite;
    verifyLine.frame = CGRectMake(STWidth(47), STHeight(317), STWidth(280), 0.5f);
    [self addSubview:verifyLine];
    
    _tipLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c01 backgroundColor:nil multiLine:NO];
    _tipLabel.frame = CGRectMake(STWidth(47), STHeight(331), STWidth(280), STHeight(20));
    [self addSubview:_tipLabel];
    
    
    _loginBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_LOGIN_BTN_LOGIN textColor:[cwhite colorWithAlphaComponent:0.5f] backgroundColor:[c01 colorWithAlphaComponent:0.5f] corner:STHeight(25) borderWidth:0 borderColor:nil];
    _loginBtn.frame = CGRectMake(STWidth(27), STHeight(374), STWidth(320), STWidth(50));
    [_loginBtn setBackgroundColor:c01 forState:UIControlStateHighlighted];
    [self addSubview:_loginBtn];
    _loginBtn.enabled = NO;
    [_loginBtn addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _sendVerifyCodeBtn =  [[UIButton alloc]initWithFont:STFont(14) text:_mViewModel.loginModel.verifyStr textColor:cwhite backgroundColor:[UIColor clearColor] corner:0 borderWidth:0 borderColor:nil];
    if(IS_IPHONE_X){
        _sendVerifyCodeBtn.frame = CGRectMake(STWidth(232), STHeight(260), STWidth(100) , STHeight(56));
    }else{
        _sendVerifyCodeBtn.frame = CGRectMake(STWidth(252), STHeight(260), STWidth(80) , STHeight(56));
    }
    _sendVerifyCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sendVerifyCodeBtn];
    [_sendVerifyCodeBtn addTarget:self action:@selector(doSendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}

-(void)doSendVerifyCode{
    if(_mViewModel){
        [_mViewModel sendVerifyCode:_phoneNumTF.text];
    }
}


-(void)doWechatLogin{
    if(_mViewModel){
        [_mViewModel doWechatLogin];
    }
}

-(void)doLogin{
    if(_mViewModel){
        [_mViewModel doLogin:_phoneNumTF.text verifyCode:_verifyCodeTF.text];
    }
}


-(void)updateVerifyBtn:(Boolean)complete{
    [_sendVerifyCodeBtn setTitle:_mViewModel.loginModel.verifyStr forState:UIControlStateNormal];
    [self changeLoginBtnStatu];
    if(complete){
        [_sendVerifyCodeBtn setEnabled:YES];
        [_sendVerifyCodeBtn setTitleColor:cwhite forState:UIControlStateNormal];
    }else{
        [_sendVerifyCodeBtn setEnabled:NO];
        [_sendVerifyCodeBtn setTitleColor:c01 forState:UIControlStateNormal];
    }
}

-(void)onLoginCallback{
    _tipLabel.text = _mViewModel.loginModel.msgStr;
    _tipLabel.textColor = _mViewModel.loginModel.msgColor;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneNumTF resignFirstResponder];
    [_verifyCodeTF resignFirstResponder];
}


- (void)textFieldDidChange:(UITextField *)textField{
    [self changeLoginBtnStatu];
}

-(void)changeLoginBtnStatu{
    if(!IS_NS_STRING_EMPTY(_phoneNumTF.text) && !IS_NS_STRING_EMPTY(_verifyCodeTF.text)){
        [_loginBtn setBackgroundColor:cwhite forState:UIControlStateNormal];
        _loginBtn.enabled = YES;
        [_loginBtn setTitleColor:c02 forState:UIControlStateNormal];
    }else{
        [_loginBtn setBackgroundColor:c01 forState:UIControlStateNormal];
        _loginBtn.enabled = NO;
        [_loginBtn setTitleColor:[cwhite colorWithAlphaComponent:0.5f] forState:UIControlStateNormal];
    }
}

@end
