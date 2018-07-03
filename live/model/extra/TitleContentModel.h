//
//  TitleContentModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleContentModel : NSObject

@property(copy, nonatomic)NSString *title;
@property(copy, nonatomic)NSString *content;
@property(assign, nonatomic)Boolean isSwitch;


+(TitleContentModel *)buildModel:(NSString *)title content:(NSString *)content;


+(TitleContentModel *)buildModel:(NSString *)title content:(NSString *)content isSwitch:(Boolean)isSwitch;

@end
