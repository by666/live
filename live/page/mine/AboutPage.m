//
//  AboutPage.m
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AboutPage.h"

@interface AboutPage ()

@end

@implementation AboutPage

+(void)show:(BaseViewController *)controller{
    AboutPage *page = [[AboutPage alloc]init];
    [controller pushPage:page];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_ABOUT_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setStatuBarBackgroud:c18];
}

-(void)initView{
    
}
@end
