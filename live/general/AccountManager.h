//
//  AccountManager.h
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface AccountManager : NSObject
SINGLETON_DECLARATION(AccountManager)

//存储用户账户信息
-(void)saveUserModel:(UserModel *)model;

//获取用户账户信息
-(UserModel *)getUserModel;

//清除用户账户信息
-(void)clearUserModel;


////////////////////////////////////

//是否登录
-(Boolean)isLogin;

//刷新token
-(void)refreshToken;


@end
