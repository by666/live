//
//  STUserDefaults.h
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STUserDefaults : NSObject


+(Boolean)saveKeyValue:(NSString *)key value:(id)value;
+(id)getKeyValue:(NSString *)key;

+(Boolean)saveImage:(NSString *)key image:(UIImage *)image;
+(UIImage *)getImage:(NSString *)key;

//注意model必须实现NSCoding才可以使用
+(Boolean)saveModel:(NSString *)key model:(id)model;
+(id)getModel:(NSString *)key;
+(void)removeModel:(NSString *)key;



@end
