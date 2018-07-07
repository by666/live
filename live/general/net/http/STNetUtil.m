//
//  STNetUtil.m
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STNetUtil.h"
#import <AFNetworking/AFNetworking.h>
#import "RespondModel.h"
#import <MJExtension/MJExtension.h>
//#import "AccountManager.h"
#import "STConvertUtil.h"
#import "STObserverManager.h"
#import "STUserDefaults.h"
@implementation STNetUtil


#pragma mark get传参
+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(RespondModel *))success failure:(void (^)(int))failure{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //header
//    UserModel *model =[[AccountManager sharedAccountManager]getUserModel];
//    if(!IS_NS_STRING_EMPTY(model.token) && !IS_NS_STRING_EMPTY(model.userUid)){
//        [manager.requestSerializer setValue:model.token forHTTPHeaderField:@"token"];
//        [manager.requestSerializer setValue:model.userUid forHTTPHeaderField:@"uid"];
//    }
//
    //content-type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil ];
    
    //get
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccess:responseObject success:success url:url];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFail:task.response failure:failure url:url];
    }];
}


#pragma mark post传参
+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(RespondModel *))success failure:(void (^)(int))failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //header
//    UserModel *model =[[AccountManager sharedAccountManager]getUserModel];
//    if(!IS_NS_STRING_EMPTY(model.token) && !IS_NS_STRING_EMPTY(model.userUid)){
//        [manager.requestSerializer setValue:model.token forHTTPHeaderField:@"token"];
//        [manager.requestSerializer setValue:model.userUid forHTTPHeaderField:@"uid"];
//    }
    
    //content-type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil ];
    
    //post
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccess:responseObject success:success url:url];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFail:task.response failure:failure url:url];
    }];
}



#pragma mark post传递body
+(void)post:(NSString *)url content:(NSString *)content success:(void (^)(RespondModel *))success failure:(void (^)(int))failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //header
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
//    UserModel *model =[[AccountManager sharedAccountManager]getUserModel];
//    if(!IS_NS_STRING_EMPTY(model.token) && !IS_NS_STRING_EMPTY(model.userUid)){
//        [request addValue:model.token forHTTPHeaderField:@"token"];
//        [request addValue:model.userUid forHTTPHeaderField:@"uid"];
//    }
    
    //content-type
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    //body
    NSData *body  =[content dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:body];
    
    
    //post
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if(error){
            [self handleFail:response failure:failure url:url];
        }else{
            [self handleSuccess:responseObject success:success url:url];
        }
    }] resume];
}


#pragma mark 上传
+(void)upload:(UIImage *)image url:(NSString *)url success:(void (^)(RespondModel *))success failure:(void (^)(int))errorCode{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    NSData *data = UIImageJPEGRepresentation(image,1.0);
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"upload.png" mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccess:responseObject success:success url:url];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFail:task.response failure:errorCode url:url];
    }];
    
    
}
#pragma mark 下载
+(void)download : (NSString *)url callback : (ByDownloadCallback) callback{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}


#pragma mark 成功处理
+(void)handleSuccess:(id)responseObject success:(void (^)(RespondModel *))success url:(NSString *)url{
    RespondModel *model = [RespondModel mj_objectWithKeyValues:responseObject];
    model.requestUrl = url;
    dispatch_main_async_safe((^{
        if(model.code  == 200){
            if([responseObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *dic = responseObject;
                NSString *jsonStr = [NSString stringWithFormat:@"\n------------------------------------\n***请求成功:%@\n%@\n------------------------------------",url,[dic mj_JSONString]];
                [STLog print:jsonStr];
            }else{
                NSString *jsonStr = [NSString stringWithFormat:@"\n------------------------------------\n***请求成功:%@\n%@\n------------------------------------",url,[STConvertUtil dataToString:responseObject]];
                [STLog print:jsonStr];
            }
            
        }else{
            [self printErrorInfo:model url:url];
        }
        success(model);
    }));
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}


#pragma mark 失败处理
+(void)handleFail : (NSURLResponse *)response failure:(void (^)(int))failure url:(NSString *)url{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    NSInteger errorCode = httpResponse.statusCode;
    NSString *errorInfo = [NSString stringWithFormat:@"\n------------------------------------\n***url:%@\n***网络错误码:%ld\n------------------------------------",url,errorCode];
    [STLog print:errorInfo];
    dispatch_main_async_safe(^{
        failure((int)errorCode);
    });
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}


#pragma mark 打印请求错误信息
+(void)printErrorInfo:(RespondModel *)model url:(NSString *)url{
    NSString *body = @"";
    if([model.data isKindOfClass:[NSData class]]){
        body = [STConvertUtil dataToString:model.data];
    }
    if([model.data isKindOfClass:[NSDictionary class]]){
        body = [model.data mj_JSONString];
    }
    NSString *errorInfo = [NSString stringWithFormat:@"\n------------------------------------\n***url:%@ \n***请求错误码:%d \n***错误信息:%@\n------------------------------------\n%@",url,model.code,model.msg,body];
    
    [STLog print:errorInfo];
}



+(Boolean)getNetStatu{
    int netStatu = [[ STUserDefaults getKeyValue:UD_NET_STATU] intValue];
    return (netStatu == 1) ? YES : NO;
}


#pragma mark 监听网络状态
+(void)startListenNetWork{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            NSLog(@"当前网络：未知网络");
            [STUserDefaults saveKeyValue:UD_NET_STATU value:@(0)];
        } else if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"当前网络：没有网络");
            [STUserDefaults saveKeyValue:UD_NET_STATU value:@(0)];
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            NSLog(@"当前网络：手机流量");
            [STUserDefaults saveKeyValue:UD_NET_STATU value:@(1)];
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"当前网络：WiFi");
            [STUserDefaults saveKeyValue:UD_NET_STATU value:@(1)];
        }
    }];
    [manager startMonitoring];
}


@end
