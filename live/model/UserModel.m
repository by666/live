//
//  UserModel.m
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self == [super init]){
        self.phoneNum = [aDecoder decodeObjectForKey:@"phoneNum"];
        self.headUrl = [aDecoder decodeObjectForKey:@"headUrl"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.userUid = [aDecoder decodeObjectForKey:@"userUid"];
        self.token = [aDecoder decodeObjectForKey:@"token"];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.phoneNum forKey:@"phoneNum"];
    [aCoder encodeObject:self.headUrl forKey:@"headUrl"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userUid forKey:@"userUid"];
    [aCoder encodeObject:self.token forKey:@"token"];

}

@end
