//
//  TitleContentModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "TitleContentModel.h"

@implementation TitleContentModel


+(TitleContentModel *)buildModel:(NSString *)title content:(NSString *)content{
    TitleContentModel *model = [[TitleContentModel alloc]init];
    model.title = title;
    model.content = content;
    return model;
}

+(TitleContentModel *)buildModel:(NSString *)title content:(NSString *)content isSwitch:(Boolean)isSwitch{
    TitleContentModel *model = [[TitleContentModel alloc]init];
    model.title = title;
    model.content = content;
    model.isSwitch = isSwitch;
    return model;
}
@end
