//
//  ChatModel.h
//  live
//
//  Created by 黄成实 on 2018/6/26.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ChatIdentify){
    CI_System = 0,
    CI_Mine,
    CI_User
};

@interface ChatModel : NSObject

@property(assign, nonatomic)long uid;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *content;
@property(assign,nonatomic)ChatIdentify identify;


+(ChatModel *)buildModel:(long)uid name:(NSString *)name content:(NSString *)content identify:(ChatIdentify)identify;

 @end
