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

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    DetailPage *controller = [[DetailPage alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [[STObserverManager sharedSTObserverManager]setup];
    [self initNet];
    [self initUmeng];
    [self initAdmob];
    [STUpdateUtil checkUpdate:^(NSString *appname, NSString *url, double version) {
//                [self showUpdateAlert:url version:version];
    }];
    


    
    
    return YES;
}


-(void)initNet{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
}

-(void)initUmeng{
    UMConfigInstance.appKey = UMENG_APPKEY;
    UMConfigInstance.channelId = CHANNELCODE;
    [MobClick startWithConfigure:UMConfigInstance];
}

-(void)initAdmob{
    [GADMobileAds configureWithApplicationID:ADMOB_APPID];
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ @"a046e84d7e0211e877a2eb9fbb805669dddd972a"];
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
