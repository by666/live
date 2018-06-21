//
//  STUpdateUtil.h
//  framework
//
//  Created by 黄成实 on 2018/5/3.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STUpdateUtil : NSObject

typedef void(^UpdateBlock)(NSString *appname,NSString *url,double version);

+(void)checkUpdate:(UpdateBlock)block;

@end
