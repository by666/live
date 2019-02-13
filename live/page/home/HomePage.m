//
//  HomePage.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "HomePage.h"
#import "HomeView.h"

@interface HomePage()<HomeViewDelegate>
    
@property(strong, nonatomic)HomeView *homeView;
@property(strong, nonatomic)HomeViewModel *viewModel;

@end

@implementation HomePage
    
+(void)show:(BaseViewController *)controller{
    HomePage *page = [[HomePage alloc]init];
    [controller pushPage:page];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:@"" needback:YES];
    [self initView];
}
    
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite style:UIStatusBarStyleDefault];
}
    
-(void)initView{
    _viewModel = [[HomeViewModel alloc]init];
    _viewModel.delegate = self;
    
    _homeView =[[HomeView alloc]initWithViewModel:_viewModel];
    _homeView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_homeView];
}
    
-(void)onRequestBegin{
    
}
    
-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    
}
    
-(void)onRequestFail:(NSString *)msg{
    
}


@end

