//
//  AgreementPage.m
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AgreementPage.h"

@interface AgreementPage ()

@end

@implementation AgreementPage

+(void)show:(BaseViewController *)controller{
    AgreementPage *page = [[AgreementPage alloc]init];
    [controller pushPage:page];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_AGEENMENT_TITLE needback:YES];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initView{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"agreement" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    CGSize contentSize = [content sizeWithMaxWidth:(ScreenWidth - STWidth(30)) font:[UIFont systemFontOfSize:STFont(16)]];

  
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    scrollView.contentSize = CGSizeMake(ScreenWidth, contentSize.height);
    [self.view addSubview:scrollView];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFont:STFont(16) text:content textAlignment:NSTextAlignmentLeft textColor:cblack backgroundColor:nil multiLine:YES];
    contentLabel.frame = CGRectMake(STWidth(15),  0,ScreenWidth - STWidth(30), contentSize.height);
    [scrollView addSubview:contentLabel];
}
@end
