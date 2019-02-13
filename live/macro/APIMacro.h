//
//  APIMacro.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//



#import <Foundation/Foundation.h>

#pragma mark 定义API相关

#define RootUrl @"https://yuepaoapi.cn/live"



#pragma mark 登录

//启动
#define URL_APPINFO           [RootUrl stringByAppendingString:@"/api/app/check"]
//获取验证码
#define URL_GETVERIFYCODE       [RootUrl stringByAppendingString:@"/api/sms/send"]
//登录
#define URL_LOGIN               [RootUrl stringByAppendingString:@"/api/login"]

#pragma mark 直播

//直播列表
#define URL_LIVE_LIST [RootUrl stringByAppendingString:@"/api/lives"]
//直播详情
#define URL_LIVE_DETAIL [RootUrl stringByAppendingString:@"/api/kktv"]
//赠送礼物
#define URL_SEND_GIFT [RootUrl stringByAppendingString:@"/api/gift"]
//投诉
#define URL_SEND_REPORT [RootUrl stringByAppendingString:@"/api/report"]


#pragma mark 会员

//会员列表
#define URL_VIP_LIST [RootUrl stringByAppendingString:@"/api/vip_list"]
//会员订单生成
#define URL_VIP_ORDER [RootUrl stringByAppendingString:@"/api/vip_order"]

//钻石列表
#define URL_MONEY_LIST [RootUrl stringByAppendingString:@"/api/money_list"]
//钻石订单生成
#define URL_MONEY_ORDER [RootUrl stringByAppendingString:@"/api/money_order"]



#pragma mark 网络请求码

#define CODE_SUCCESS 200
