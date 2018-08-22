
//
//  STPUtil.m
//  gogo
//
//  Created by by.huang on 2017/10/21.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "STPUtil.h"

@implementation STPUtil

+(CGFloat)getActualWidth : (CGFloat)width{
    return (ScreenWidth * width) / 375;
}

+(CGFloat)getActualHeight : (CGFloat)height{
    if(IS_IPHONE_X){
        
        return height * 1.1;
        
    }
    return (ScreenHeight * height) / 676;
}

+(double)getAppVersion{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    return [currentVersion doubleValue];
}

+(Boolean)isPhoneNumValid:(NSString *)phoneNum{
    if (IS_NS_STRING_EMPTY(phoneNum) ||  phoneNum.length != 11){
        return NO;
    }
    NSString *regex = @"^1(3[0-9]|4[0-9]|5[0-9]|8[0-9]|7[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regextestmobile evaluateWithObject:phoneNum];
}

+(Boolean)isVerifyCodeValid:(NSString *)verifyCode{
    if(!IS_NS_STRING_EMPTY(verifyCode) && (verifyCode.length >= 4) && (verifyCode.length <=8)){
        return YES;
    }
    return NO;
}

+(Boolean)isIdNumberValid:(NSString *)idNum{
    if (idNum.length != 18) return NO;
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if(![identityStringPredicate evaluateWithObject:idNum]) return NO;
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[idNum substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    NSInteger idCardMod=idCardWiSum % 11;
    NSString *idCardLast= [idNum substringWithRange:NSMakeRange(17, 1)];
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"] && ![idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}


+(Boolean)isCarNumberValid:(NSString *)carNum{
    if(IS_NS_STRING_EMPTY(carNum)){
        return NO;
    }
    if(carNum.length == 5 || carNum.length == 6){
        return YES;
    }
    return NO;
}


+(CGSize)textSize:(NSString *)text maxWidth:(CGFloat)maxWidth font:(CGFloat)font{
    return [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}



+(NSString *)getBirthdayFromIdNum:(NSString *)idNum{
    if(!IS_NS_STRING_EMPTY(idNum) && (idNum.length == 15 || idNum.length == 18)){
        NSString *month = [idNum substringWithRange:NSMakeRange(10, 2)];
        NSString *day = [idNum substringWithRange:NSMakeRange(12,2)];
        return [NSString stringWithFormat:@"%@.%@",month,day];
    }
    return @"";
}


+(NSString *)getGenderfromIdNum:(NSString *)numberStr{
    if(IS_NS_STRING_EMPTY(numberStr)){
        return @"";
    }
    NSString *sex = @"";
    if (numberStr.length==18){
        int sexInt=[[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
        if(sexInt%2!=0){
            sex = @"男";
        }else{
            sex = @"女";
        }
    }
    if (numberStr.length==15){
        int sexInt=[[numberStr substringWithRange:NSMakeRange(14,1)] intValue];
        if(sexInt%2!=0){
            sex = @"男";
        }else{
            sex = @"女";
        }
    }
    return sex;
}


+(NSString *)getSecretPhoneNum:(NSString *)phoneNum{
    if(IS_NS_STRING_EMPTY(phoneNum) || phoneNum.length != 11){
        return @"";
    }
    NSString *start = [phoneNum substringWithRange:NSMakeRange(0, 3)];
    NSString *end = [phoneNum substringWithRange:NSMakeRange(7, 4)];
    return [NSString stringWithFormat:@"%@****%@",start,end];
}
@end
