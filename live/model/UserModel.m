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
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.nick = [aDecoder decodeObjectForKey:@"nick"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.diamond =  (long)[aDecoder decodeIntegerForKey:@"diamond"];
        self.view_count =  [aDecoder decodeIntForKey:@"view_count"];
        self.chat_state = [aDecoder decodeObjectForKey:@"chat_state"];
        self.create_ts = [aDecoder decodeObjectForKey:@"create_ts"];
        self.expired_ts = [aDecoder decodeObjectForKey:@"expired_ts"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.nick forKey:@"nick"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeInteger:self.diamond forKey:@"diamond"];
    [aCoder encodeInt:self.view_count forKey:@"view_count"];
    [aCoder encodeObject:self.chat_state forKey:@"chat_state"];
    [aCoder encodeObject:self.create_ts forKey:@"create_ts"];
    [aCoder encodeObject:self.expired_ts forKey:@"expired_ts"];

}

@end
