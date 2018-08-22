//
//  STPUtil.h
//  gogo
//
//  Created by by.huang on 2017/10/21.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STPUtil : NSObject

//比例宽
+(CGFloat)getActualWidth : (CGFloat)width;

//比例高
+(CGFloat)getActualHeight : (CGFloat)height;

//APP版本
+(double)getAppVersion;

//手机号是否有效
+(Boolean)isPhoneNumValid:(NSString *)phoneNum;

//验证码是否有效
+(Boolean)isVerifyCodeValid:(NSString *)verifyCode;

//身份证号码是否有效
+(Boolean)isIdNumberValid:(NSString *)idNum;

//车牌号是否有效
+(Boolean)isCarNumberValid:(NSString *)carNum;

//计算字符串宽度
+(CGSize)textSize:(NSString *)text maxWidth:(CGFloat)maxWidth font:(CGFloat)font;

//通过身份证号获取生日
+(NSString *)getBirthdayFromIdNum:(NSString *)idNum;

//通过身份证号获取性别
+(NSString *)getGenderfromIdNum:(NSString *)numberStr;

//11位电话号码隐藏
+(NSString *)getSecretPhoneNum:(NSString *)phoneNum;


@end
