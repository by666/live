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

@implementation STNetUtil

+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    //请求头
//    Account *account = [[AccountManager sharedAccountManager] getAccount];
//    [manager.requestSerializer setValue:PT forHTTPHeaderField:@"pt"];
//    [manager.requestSerializer setValue:APPKEY forHTTPHeaderField:@"app_key"];
//    [manager.requestSerializer setValue:account.uid forHTTPHeaderField:@"uid"];
//    [manager.requestSerializer setValue:account.access_token forHTTPHeaderField:@"access_token"];
    // 请求参数类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil ];
    // post请求
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //请求头
//    Account *account = [[AccountManager sharedAccountManager] getAccount];
//    [manager.requestSerializer setValue:PT forHTTPHeaderField:@"pt"];
//    [manager.requestSerializer setValue:APPKEY forHTTPHeaderField:@"app_key"];
//    [manager.requestSerializer setValue:account.uid forHTTPHeaderField:@"uid"];
//    [manager.requestSerializer setValue:account.access_token forHTTPHeaderField:@"access_token"];
    // 请求参数类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil ];
    // post请求
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            RespondModel *model = [RespondModel mj_objectWithKeyValues:responseObject];
            success(model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            failure(error);
        }
    }];
}


+(void)post:(NSString *)url content:(NSString *)content success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
     [manager.requestSerializer setValue:@"Cookie" forHTTPHeaderField:@"BAIDUID=AB66A50E7E2BEA84B6E65589B4B88949:FG=1; BIDUPSID=AB66A50E7E2BEA84B6E65589B4B88949; PSTM=1523866235; Hm_lvt_fdad4351b2e90e0f489d7fbfc47c8acf=1524448930,1524448969,1524449288,1524794616; BDORZ=B490B5EBF6F3CD402E515D22BCDA1598; Hm_lvt_9b5b797a3c99bd63dcd4205c51040c24=1526017407; BDUSS=piSE9zYm1EVnFqOUxWanlhd1ZzSzgxfk1sOTE4cG5JS3hOT0RrTlRpdXV1aHhiQUFBQUFBJCQAAAAAAAAAAAEAAABzccAcamdzaHVhbmcAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAK4t9VquLfVaOG; __cas__st__=NLI; __cas__id__=0; isNew=12966; Hm_lvt_2e0bc8c5e7ceb25796ba4962e7b57387=1526017515; PHPSESSID=j7st2oh1jq9m92fkfij30d3e47; docVersion=0; BDRCVFR[feWj1Vr5u3D]=I67x6TjHwwYf0; PSINO=7; Hm_lpvt_2e0bc8c5e7ceb25796ba4962e7b57387=1526036675; FP_UID=80a589aa889f2747a050d5291a871498; Hm_lpvt_fdad4351b2e90e0f489d7fbfc47c8acf=1526040588; BCLID=11844230970861625741; BDSFRCVID=CHFsJeC627PjoXoAn8X2MZI0cbsG6K3TH6ao5t-DGEZcbZ9VT_IjEG0PDU8g0Ku-MWTXogKK3gOTH4nP; H_BDCLCKID_SF=tRk8_KtKtCI3HnRY-P4_-tAt2qoXetJyaR0f_x7bWJ5TMC_wLfTF-l_F0-OnQUrzWR7C0lT1B43GShPC-tn25PLuqtRX-5JGQCtqLbAE3l02Vhbae-t2yU_V34uHe4RMW20e0h7mWIb_VKF6jjLWjTcBepJf-K6tK5RK3488Kb7VbPb3Bnbkbftd2-te36j3Lm6TKnDbtfA-jRQx3b5V-xkSQGjNt5JZfJktoCP5fCL3fP36qRojK-__KgT22-uste6AQhcH0KLKqlTGK6OoLq8v-qjuXfFeK2JhMMn-aMb1MRjv-pLKWbKXDMJ-tnvWbCraaq5TtUJUeCnTDMRhqtkf-PTyKMnitKv9-pP2aft0hCKRj5LMDjjMKpOy5-PX5Ic035rJaDvHexJRy4oTj6DdhhoIL4RCLn6-Lh6uWlojhhcSQ5oD3MvB-fnetUoEL65C2K3TBCbmeJ3MQft20M0beMtjBbQaMjcxKR7jWhk5ep72y5O_05TLDNADJ5LHfK60sJoq2RbhKROvhjRm0R0yyxomtjjNa23bLRrpaJ5chq6Lyj3jqqku-PoZLUkqKCOt_fnyyfJa8lOkbfJjyR3-QttjQU3OfIkjahDELKopqJ7TyU45bU47yaOXQTIeJbkqVC_Qb-3bK4ONbJrohCCShUFsancJ-2Q-5KL-fCJYjf7PLtTMXb8IW4uj5M79-G72BfbdJJjoePcwD67E35_LyR33-p_eQmTxoUJh5DnJhhvGqJbiXU-ebPRiJ-b9Qg-JWftLJK02MCIwD6RD5tbH5Moe-PcXHD7XVhOd3tOkeq8CD6JmM44RhPQXqpkHBGQAonOt-h0-OIO2y5jHhTL3qtOx0lT2KHL8-fb7WRcpsIJMQh_WbT8U5ecuLh3vaKviaKOjBMb1MbrMe4bK-TryjHufJf5; locale=zh; H_PS_PSSID=1450_26357_21115_20692_20928; Hm_lpvt_9b5b797a3c99bd63dcd4205c51040c24=1526095135"];
    //请求头
//    Account *account = [[AccountManager sharedAccountManager] getAccount];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:PT forHTTPHeaderField:@"pt"];
//    [request addValue:APPKEY forHTTPHeaderField:@"app_key"];
//    [request addValue:account.uid forHTTPHeaderField:@"uid"];
//    [request addValue:account.access_token forHTTPHeaderField:@"access_token"];
    
    NSData *body  =[content dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:body];
    
    [[manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error){
            if (failure){
                failure(error);
            }
        }else{
            if (success){
                NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(string);
                RespondModel *model = [RespondModel mj_objectWithKeyValues:responseObject];
                success(model);
            }
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    }] resume];
    
}


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

+(void)refreshToken : (RefreshCompelete)compelete{
    
//    Account *account = [[AccountManager sharedAccountManager]getAccount];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    dic[@"refresh_token"]=account.refresh_token ;
//    [self post:API_REFRESH_TOKEN parameters:dic success:^(RespondModel *respondModel) {
//        if(respondModel.code == 200){
//            id data = respondModel.data;
//            LoginModel *model = [LoginModel mj_objectWithKeyValues:data];
//            account.uid = model.uid;
//            account.access_token = model.access_token;
//            account.refresh_token = model.refresh_token;
//            [[AccountManager sharedAccountManager] saveAccount:account];
//        }
//        compelete(respondModel);
//    } failure:^(NSError *error) {
//
//    }];
}
@end
