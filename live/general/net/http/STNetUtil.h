//
//  STNetUtil.h
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RespondModel.h"

@interface STNetUtil : NSObject

typedef void(^ByDownloadCallback)(id respondObj);

typedef void(^RefreshCompelete)(id data);


+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id ))success failure:(void (^)(NSError *))failure;

+(void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id ))success failure:(void (^)(NSError *))failure;

+(void)post:(NSString *)url content:(NSString *)content success:(void (^)(id ))success failure:(void (^)(NSError *))failure;

+(void)download : (NSString *)url callback : (ByDownloadCallback) callback;

+(void)refreshToken : (RefreshCompelete)compelete;

@end
