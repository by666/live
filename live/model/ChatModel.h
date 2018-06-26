//
//  ChatModel.h
//  live
//
//  Created by 黄成实 on 2018/6/26.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject

@property(assign, nonatomic)long uid;
@property(copy, nonatomic)NSString *name;
@property(assign,nonatomic)int level;
 
@end
