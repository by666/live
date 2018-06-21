//
//  STUpdateUtil.m
//  framework
//
//  Created by 黄成实 on 2018/5/3.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STUpdateUtil.h"
#import <AFNetworking/AFNetworking.h>

@implementation STUpdateUtil

+(void)checkUpdate:(UpdateBlock)block{
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=1205941337"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
            NSMutableArray *array = [dict mutableArrayValueForKey:@"results"];
            if(!IS_NS_COLLECTION_EMPTY(array)){
                NSDictionary *dataDic  = [array objectAtIndex:0];
                NSString *downUrl = [dataDic objectForKey:@"trackViewUrl"];
                NSString *appName = [dataDic objectForKey:@"trackName"];
                double newVersion = [[dataDic objectForKey:@"version"] doubleValue];
                double currentVersion =  [STPUtil getAppVersion];
                if(newVersion > currentVersion){
                    block(appName,downUrl,newVersion);
                }else{
                    [STLog print:@"当前app版本" content:[NSString stringWithFormat:@"%.2f",currentVersion]];
                }
            }
        }
    }];
    [sessionDataTask resume];
}
@end
