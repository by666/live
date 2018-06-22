//
//  MainModel.h
//  live
//
//  Created by 黄成实 on 2018/6/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject

@property(strong, nonatomic)NSString *origin;
@property(strong, nonatomic)NSString *nick;
@property(strong, nonatomic)NSString *avatar;
@property(strong, nonatomic)NSString *city;
@property(assign, nonatomic)long room_id;


@end
