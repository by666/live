//
//  AccountManager.m
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AccountManager.h"
#import "STUserDefaults.h"

@implementation AccountManager
SINGLETON_IMPLEMENTION(AccountManager)


///
-(void)saveUserModel:(UserModel *)model{
    [STUserDefaults saveModel:UD_USERMODEL model:model];
 }

-(UserModel *)getUserModel{
    if([STUserDefaults getModel:UD_USERMODEL]){
        return [STUserDefaults getModel:UD_USERMODEL];
    }
    return [UserModel new];
}

-(void)clearUserModel{
    [STUserDefaults removeModel:UD_USERMODEL];
}


-(Boolean)isLogin{
    UserModel *model = [self getUserModel];
    if(model && !IS_NS_STRING_EMPTY(model.token) && !IS_NS_STRING_EMPTY(model.userUid)){
        return YES;
    }
    return NO;
}

-(void)refreshToken{
    //todo
    
}

@end
