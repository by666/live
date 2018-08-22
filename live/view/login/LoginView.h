//
//  LoginView.h
//  live
//
//  Created by 黄成实 on 2018/8/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"

@interface LoginView : UIView


-(instancetype)initWithViewModel:(LoginViewModel *)viewModel;
//验证码按钮UI变化
-(void)updateVerifyBtn:(Boolean)complete;
//登录验证
-(void)onLoginCallback;

@end
