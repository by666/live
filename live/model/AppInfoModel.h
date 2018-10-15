//
//  AppInfoModel.h
//  live
//
//  Created by by.huang on 2018/10/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfoModel : NSObject


@property(assign, nonatomic)int vc;
@property(copy, nonatomic)NSString *app_name;
@property(copy, nonatomic)NSString *android_app_url;
@property(copy, nonatomic)NSString *ios_app_url;
@property(copy, nonatomic)NSString *state;


@end

