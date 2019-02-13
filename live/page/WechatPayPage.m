//
//  WechatPayPage.m
//  live
//
//  Created by by.huang on 2018/10/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "WechatPayPage.h"

@interface WechatPayPage ()<UIWebViewDelegate>

@end

@implementation WechatPayPage

+(void)show:(BaseViewController *)controller{
    WechatPayPage *page = [[WechatPayPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    webView.delegate = self;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://yinqiantong.com/html/experience/h5.html"]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSDictionary *headers = [request allHTTPHeaderFields];
    BOOL hasReferer = [headers objectForKey:@"Referer"] != nil;
    if (hasReferer) {
        // .. is this my referer?
        return YES;
    } else {
        // relaunch with a modified request
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSURL *url = [request URL];
                NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                [request setHTTPMethod:@"GET"];
                [request setValue:@"https://yinqiantong.com" forHTTPHeaderField: @"Referer"];
                [webView loadRequest:request];
            });
        });
        return NO;
    }
}


@end
