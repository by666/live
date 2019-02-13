//
//  AppDelegate.m
//  live
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AppDelegate.h"
#import "STDataBaseUtil.h"
#import "STRuntimeUtil.h"
#import "MainPage.h"
#import "STUserDefaults.h"
#import "STObserverManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "STUpdateUtil.h"
#import "UMessage.h"
#import "UMMobClick/MobClick.h"
#import "DetailPage.h"
#import "AdMobManager.h"
#import "STNetUtil.h"
#import "LoginPage.h"
#import "AppInfoModel.h"
#import "AccountManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    id controller;
//    if([[AccountManager sharedAccountManager] isLogin]){
        controller = [[MainPage alloc]init];
//    }else{
//        controller = [[LoginPage alloc]init];
//    }
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [[STObserverManager sharedSTObserverManager]setup];
    [self initNet];
    [self initUmeng];
//    [[AdMobManager sharedAdMobManager] initAdMob];
    [self initAppInfo];
    [self initAccount];
    [self initShotScreen];
    return YES;
}


//获取版本信息
-(void)initAppInfo{
    [STNetUtil get:URL_APPINFO parameters:nil success:^(RespondModel *respondModel) {
        if(respondModel.code == CODE_SUCCESS){
            AppInfoModel *model = [AppInfoModel mj_objectWithKeyValues:respondModel.data];
            //不允许进入，强制退出
            if(![model.state isEqualToString:@"online"]){
                exit(0);
                return;
            }
            //有版本更新t，跳转到网页
            double currentVersion =  [STPUtil getAppVersion];
            if(model.vc > currentVersion){
                [STPUtil openUrl:model.ios_app_url];
            }
        }
    } failure:^(int errorCode) {
        
    }];
}

//
-(void)initAccount{
    NSString *uid = [STUserDefaults getKeyValue:UD_ID];
    if(IS_NS_STRING_EMPTY(uid)){
        NSTimeInterval random=[NSDate timeIntervalSinceReferenceDate];
        NSString *randomString = [NSString stringWithFormat:@"%.8f",random];
        NSString *randompassword = [[randomString componentsSeparatedByString:@"."]objectAtIndex:1];
        [STUserDefaults saveKeyValue:UD_ID value:randompassword];
    }
}

-(void)initNet{
    
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [STNetUtil startListenNetWork];
    
}

-(void)initUmeng{
    UMConfigInstance.appKey = UMENG_APPKEY;
    UMConfigInstance.channelId = CHANNELCODE;
    [MobClick startWithConfigure:UMConfigInstance];
}

-(void)initShotScreen{
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification object:nil queue:mainQueue usingBlock:^(NSNotification *note) {
        [STLog print:@"用户截屏"];
    }];
}



#pragma mark 系统自带回调
- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {}


- (void)applicationDidBecomeActive:(UIApplication *)application {}


- (void)applicationWillTerminate:(UIApplication *)application {}




#pragma mark 3D Touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.type isEqualToString:@"ShortCutOpen"]) {
        [STLog print:@"打开App"];
    }
    
    if ([shortcutItem.type isEqualToString:@"ShortCutShare"]) {
        [STLog print:@"分享"];
    }
    
}




//打开更新对话框
-(void)showUpdateAlert:(NSString *)downUrl version:(double)version{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"检测到新版本" message:[NSString stringWithFormat:@"是否更新到新版本v%.2f",version] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8&v0=WWW-GCCN-ITSTOP100-FREEAPPS&l=&ign-mpt=uo%3D4"]];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:updateAction];
    [_window.rootViewController presentViewController:alertController animated:YES completion:nil];
}



@end
