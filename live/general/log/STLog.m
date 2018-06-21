//
//  STLog.m
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STLog.h"

@implementation STLog

+(void)print:(NSString *)content{
    if(!IS_NS_STRING_EMPTY(content)){
        NSLog(@"st print:%@",content);
    }
}

+(void)print:(NSString *)title content:(NSString *)content{
    NSLog(@"st print:%@->%@",title,content);
}



@end
