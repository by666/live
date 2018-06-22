//
//  RespondModel.h
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespondModel : NSObject

@property(assign, nonatomic)int code;
@property(copy, nonatomic)NSString *msg;
@property(strong, nonatomic)id data;
@property(copy, nonatomic)NSString *requestUrl;


@end
