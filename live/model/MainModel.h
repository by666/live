//
//  MainModel.h
//  live
//
//  Created by 黄成实 on 2018/6/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject

@property(strong, nonatomic)NSString *avatar;
@property(strong, nonatomic)NSString *live_url;
@property(strong, nonatomic)NSString *presenter_city;
@property(strong, nonatomic)NSString *presenter_name;
@property(assign, nonatomic)long live_id;
@property(strong, nonatomic)NSString *cover_url;
@property(strong, nonatomic)NSString *tags;
@property(assign, nonatomic)long total_view;
@property(assign, nonatomic)long presenter_distance;



@end
