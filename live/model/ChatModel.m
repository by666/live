//
//  ChatModel.m
//  live
//
//  Created by 黄成实 on 2018/6/26.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel

+(ChatModel *)buildModel:(long)uid name:(NSString *)name content:(NSString *)content identify:(ChatIdentify)identify{
    ChatModel *model = [[ChatModel alloc]init];
    model.uid = uid;
    model.name = name;
    model.content = content;
    model.identify = identify;
    return model;
}

@end
