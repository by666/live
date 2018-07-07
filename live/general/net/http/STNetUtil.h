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


+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(RespondModel *))success failure:(void (^)(int))errorCode;

+(void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(RespondModel *))success failure:(void (^)(int))errorCode;

+(void)post:(NSString *)url content:(NSString *)content success:(void (^)(RespondModel *))success failure:(void (^)(int))errorCode;

+(void)upload:(UIImage *)image url:(NSString *)url success:(void (^)(RespondModel *))success failure:(void (^)(int))errorCode;

+(void)download : (NSString *)url callback : (ByDownloadCallback) callback;

+(void)startListenNetWork;

+(Boolean)getNetStatu;

@end
