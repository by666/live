
//
//  STLog.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STLog : NSObject

+(void)print:(NSString *)content;
+(void)print:(NSString *)title content:(NSString *)content;

@end
