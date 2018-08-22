//
//  APIMacro.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//



#import <Foundation/Foundation.h>

#pragma mark 定义API相关

#define RootUrl @"https://scrats.cn/live"
//#define URL_LIVE_LIST [RootUrl stringByAppendingString:@"/api/live_list"]
#define URL_LIVE_LIST [RootUrl stringByAppendingString:@"/api/kktv_list"]

#define URL_LIVE_DETAIL [RootUrl stringByAppendingString:@"/api/kktv"]
//#define URL_LIVE_DETAIL [RootUrl stringByAppendingString:@"/api/live"]



#pragma mark 登录

//获取验证码
#define URL_GETVERIFYCODE       [RootUrl stringByAppendingString:@"/user/login/smsCode"]
//登录
#define URL_LOGIN               [RootUrl stringByAppendingString:@"/user/login/smsLogin"]
//登出
#define URL_LOGOUT              [RootUrl stringByAppendingString:@"/user/logout"]
//微信登录
#define URL_WX_LOGIN            [RootUrl stringByAppendingString:@"/user/login/wxLogin"]




#pragma mark 网络请求码

#define CODE_SUCCESS 200
