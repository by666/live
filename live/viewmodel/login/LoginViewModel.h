//
//  LoginViewModel.h
//  live
//
//  Created by 黄成实 on 2018/8/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@protocol LoginDelegate<BaseRequestDelegate>

-(void)onWechatLogin:(Boolean)success msg:(NSString *)msg;
-(void)onTimeCount:(Boolean)complete;

@end

@interface LoginViewModel:NSObject

@property(weak, nonatomic)id <LoginDelegate>delegate;
@property(strong, nonatomic)LoginModel *loginModel;

-(void)sendVerifyCode:(NSString *)phoneNum;
-(void)doLogin:(NSString *)phoneNum verifyCode:(NSString *)verifyCode;
-(void)startCountTime;
-(void)doWechatLogin;
-(void)requestWechatLogin:(NSString *)code;

@end

