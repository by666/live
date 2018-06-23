//
//  DetailModel.h
//  live
//
//  Created by by.huang on 2018/6/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property(copy, nonatomic)NSString *origin;
@property(copy, nonatomic)NSString *city;
@property(assign, nonatomic)long expire_ts;
@property(copy, nonatomic)NSString *live_type;
@property(copy, nonatomic)NSString *nick;
@property(copy, nonatomic)NSString *room_id;
@property(copy, nonatomic)NSString *avatar;
@property(copy, nonatomic)NSString *live_url;

@end
