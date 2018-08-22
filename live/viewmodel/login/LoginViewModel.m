//
//  LoginViewModel.m
//  live
//
//  Created by 黄成实 on 2018/8/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "LoginViewModel.h"
#import "STObserverManager.h"
#import "STNetUtil.h"
#import "STUserDefaults.h"

#define TIMECOUNT 60

@implementation LoginViewModel

-(instancetype)init{
    if(self == [super init]){
        _loginModel = [[LoginModel alloc]init];
        _loginModel.msgStr = @"";
        _loginModel.verifyStr = MSG_GET_VERIFYCODE;
        
    }
    return self;
}



#pragma mark 请求验证码
-(void)sendVerifyCode:(NSString *)phoneNum{
    if(_delegate){
        if(![STPUtil isPhoneNumValid:phoneNum]){
            _loginModel.msgStr = MSG_PHONENUM_ERROR;
            _loginModel.msgColor = c07;
            [_delegate onRequestFail:MSG_PHONENUM_ERROR];
            return;
        }
        [_delegate onRequestBegin];
        WS(weakSelf)
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"mobile"] = phoneNum;
        [STNetUtil get:URL_GETVERIFYCODE parameters:dic success:^(RespondModel *respondModel) {
            if(respondModel.code == CODE_SUCCESS){
                weakSelf.loginModel.msgStr = MSG_VERIFYCODE_SUCCESS;
                weakSelf.loginModel.msgColor = c06;
                [weakSelf.delegate onRequestSuccess:respondModel data:phoneNum];
                [self startCountTime];
            }else{
                weakSelf.loginModel.msgStr = respondModel.msg;
                weakSelf.loginModel.msgColor = c07;
                [weakSelf.delegate onRequestFail:respondModel.msg];
            }
            
        } failure:^(int errorCode) {
            weakSelf.loginModel.msgStr = [NSString stringWithFormat:MSG_ERROR,errorCode];
            weakSelf.loginModel.msgColor = c07;
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
    }
}


#pragma mark 微信绑定手机号登录
-(void)doLogin:(NSString *)phoneNum verifyCode:(NSString *)verifyCode{
    [self doLogin:phoneNum verifyCode:verifyCode wxToken:nil];
}

#pragma mark 请求登录
-(void)doLogin:(NSString *)phoneNum verifyCode:(NSString *)verifyCode wxToken:(NSString *)wxToken{
    if(_delegate){
        [_delegate onRequestBegin];
        if(![STPUtil isPhoneNumValid:phoneNum]){
            _loginModel.msgStr = MSG_PHONENUM_ERROR;
            _loginModel.msgColor = c07;
            [_delegate onRequestFail:MSG_PHONENUM_ERROR];
            return;
        }
        if(![STPUtil isVerifyCodeValid:verifyCode]){
            _loginModel.msgStr = MSG_VERIFYCODE_ERROR;
            _loginModel.msgColor = c07;
            [_delegate onRequestFail:MSG_VERIFYCODE_ERROR];
            return;
        }
        //todo:网络请求
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"mobile"] = phoneNum;
        dic[@"validateCode"] = verifyCode;
        if(!IS_NS_STRING_EMPTY(wxToken)){
            dic[@"wxToken"] = wxToken;
        }
        NSString *jsonStr = [dic mj_JSONString];
        WS(weakSelf)
        [STNetUtil post:URL_LOGIN content:jsonStr success:^(RespondModel *repondModel) {
//            if([repondModel.status isEqualToString:STATU_SUCCESS]){
//                UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
//                model.phoneNum = phoneNum;
//                model.token = [repondModel.data objectForKey:@"token"];
//                model.userUid = [repondModel.data objectForKey:@"userUid"];
//                [[AccountManager sharedAccountManager]saveUserModel:model];
//                weakSelf.loginModel.msgStr = MSG_LOGIN_SUCCESS;
//                weakSelf.loginModel.msgColor = c06;
//                [weakSelf.delegate onRequestSuccess:repondModel data:model];
//            }else{
//                weakSelf.loginModel.msgStr = repondModel.msg;
//                weakSelf.loginModel.msgColor = c07;
//                [weakSelf.delegate onRequestFail:repondModel.msg];
//
//            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
        }];
        
        
        
        
    }
}

#pragma mark 请求微信登录
-(void)doWechatLogin{
//    if(_delegate){
//        if([WXApi isWXAppInstalled]){
//            SendAuthReq *req = [[SendAuthReq alloc] init];
//            req.scope = @"snsapi_userinfo";
//            req.state = @"wxLogin";
//            [WXApi sendReq:req];
//        }else{
//            [_delegate onWechatLogin:NO msg:MSG_NOT_INSTALL_WECHAT];
//        }
//    }
}

#pragma mark 微信登录票据换token
-(void)requestWechatLogin:(NSString *)code{
    if(_delegate){
        [_delegate onRequestBegin];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic[@"code"] = code;
        WS(weakSelf)
        [STNetUtil post:URL_WX_LOGIN content:dic.mj_JSONString success:^(RespondModel *respondModel) {
//            if([respondModel.status isEqualToString:STATU_SUCCESS]){
//                UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
//                model.token = [respondModel.data objectForKey:@"token"];
//                model.userUid = [respondModel.data objectForKey:@"userUid"];
//                [[AccountManager sharedAccountManager]saveUserModel:model];
//                weakSelf.loginModel.msgStr = MSG_LOGIN_SUCCESS;
//                weakSelf.loginModel.msgColor = c06;
//                [weakSelf.delegate onRequestSuccess:respondModel data:MSG_SUCCESS];
//            }
//            else if([respondModel.status isEqualToString:STATU_WXLOGN_NOT_BINDPHONE]){
//                NSString *wxToken = [respondModel.data objectForKey:@"wxToken"];
//                [weakSelf.delegate onRequestSuccess:respondModel data:wxToken];
//            }else{
//                [weakSelf.delegate onRequestFail:respondModel.msg];
//            }
        } failure:^(int errorCode) {
            [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
            
        }];
    }
}


#pragma mark 开始倒计时
-(void)startCountTime{
    __block NSInteger second = TIMECOUNT;
    __weak LoginViewModel *weakSelf = self;
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                second = TIMECOUNT;
                dispatch_cancel(timer);
                weakSelf.loginModel.verifyStr = MSG_GET_VERIFYCODE;
                if(weakSelf.delegate){
                    [weakSelf.delegate onTimeCount:YES];
                }
            } else {
                weakSelf.loginModel.verifyStr = [NSString stringWithFormat:@"%lds",second];
                [weakSelf.delegate onTimeCount:NO];
                second--;
            }
        });
    });
    dispatch_resume(timer);
}


@end
