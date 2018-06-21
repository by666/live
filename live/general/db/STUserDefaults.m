//
//  STUserDefaults.m
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STUserDefaults.h"
#import "STRuntimeUtil.h"

@implementation STUserDefaults

+(Boolean)saveKeyValue:(NSString *)key value:(id)value{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    Boolean result = [userDefaults synchronize];
    result ? [STLog print:@"保存成功"] : [STLog print:@"保存失败"];
    return result;
}

+(id)getKeyValue:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

+(Boolean)saveImage:(NSString *)key image:(UIImage *)image{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *imageData = UIImageJPEGRepresentation(image, 100);
    [userDefaults setObject:imageData forKey:key];
    Boolean result = [userDefaults synchronize];
    result ? [STLog print:@"保存成功"] : [STLog print:@"保存失败"];
    return result;
}

+(UIImage *)getImage:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *imageData = [userDefaults objectForKey:key];
    return [UIImage imageWithData:imageData];
}


+(Boolean)saveModel:(NSString *)key model:(id)model{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [userDefaults setObject:data forKey:key];
    Boolean result = [userDefaults synchronize];
    result ? [STLog print:@"保存成功"] : [STLog print:@"保存失败"];
    return result;
}

+(id)getModel:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}


+(void)removeModel:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
}


@end
