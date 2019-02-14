//
//  HomeView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "HomeView.h"
#import "STDouYinScrollView.h"
#import "STTopTabView.h"

@interface HomeView()<STTopTabViewDelegate>
    
@property(strong, nonatomic)HomeViewModel *mViewModel;
@property(strong, nonatomic)STDouYinScrollView *scrollView;
@property(strong, nonatomic)STTopTabView *topTabView;

@end

@implementation HomeView
    
-(instancetype)initWithViewModel:(HomeViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}
    
-(void)initView{
    _scrollView = [[STDouYinScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self addSubview:_scrollView];
    
    _topTabView = [[STTopTabView alloc]initWithTitles:@[MSG_RECOMMAND_TITLE,MSG_CITYWIDE_TITLE]];
    [self addSubview:_topTabView];
}

-(void)onTopTabSelected:(NSInteger)index{
    
}

-(void)updateView{
    
}
    
@end

