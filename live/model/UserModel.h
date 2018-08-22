//
//  UserModel.h
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>

@property (copy, nonatomic) NSString *phoneNum;
@property (copy, nonatomic) NSString *headUrl;
@property (copy, nonatomic) NSString *userName;

@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *userUid;





@end
