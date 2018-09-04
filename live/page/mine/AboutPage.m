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
    [self setStatuBarBackgroud:c01];
}

-(void)initView{
    
    CGFloat barHeight = NavigationBarHeight + StatuBarHeight;
    CGFloat width = STWidth(80);

    UIImageView *logoImageView = [[UIImageView alloc]init];
    logoImageView.frame = CGRectMake((ScreenWidth - width)/2, STHeight(60)+barHeight,  width, width);
    logoImageView.image = [UIImage imageNamed:@"icon"];
    logoImageView.layer.masksToBounds = YES;
    logoImageView.layer.cornerRadius = width/2;
    [self.view addSubview:logoImageView];
    
    UILabel *logoLabel = [[UILabel alloc]initWithFont:STFont(22) text:[NSString stringWithFormat:@"%@ %@",APP_NAME,@"v1.0"] textAlignment:NSTextAlignmentCenter textColor:cblack backgroundColor:nil multiLine:NO];
    logoLabel.frame = CGRectMake(0, STHeight(90) + barHeight + width, ScreenWidth, STHeight(22));
    [self.view addSubview:logoLabel];
    
    UILabel *copyRightLabel = [[UILabel alloc] initWithFont:STFont(12) text:@"Copyright © 2018年 by.huang. All rights reserved." textAlignment:NSTextAlignmentCenter textColor:c01 backgroundColor:nil multiLine:NO];
    copyRightLabel.frame = CGRectMake(0, ScreenHeight -  STHeight(30), ScreenWidth, STHeight(12));
    [self.view addSubview:copyRightLabel];
}
@end
