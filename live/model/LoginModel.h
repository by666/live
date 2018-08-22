//
//  LoginModel.h
//  live
//
//  Created by 黄成实 on 2018/8/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

//错误码信息
@property(copy, nonatomic)NSString *msgStr;
@property(strong, nonatomic)UIColor *msgColor;
@property(copy, nonatomic)NSString *verifyStr;

@end
