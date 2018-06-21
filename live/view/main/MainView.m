//
//  MainView.m
//  live
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainView.h"
#import "STTabBarView.h"

@interface MainView()<UIScrollViewDelegate>

@property(strong, nonatomic)MainViewModel *mViewModel;
@property(strong, nonatomic)STTabBarView *tabBarView;
@property(strong, nonatomic)UIScrollView *scrollView;

@end

@implementation MainView{
    NSInteger mIndex;
}

-(instancetype)initWithViewModel:(MainViewModel *)viewModel {
    if(self == [super init]){
        _mViewModel = viewModel;
        mIndex = 0;
        [self initView];
    }
    return self;
}

-(void)initView{
//    NSArray *titles = @[MSG_INFO_TITLE,MSG_SCHEDULE_TITLE];
    NSArray *titles = @[MSG_SCHEDULE_TITLE];
    NSArray *images = @[@"ic_info_normal",@"ic_info_select",@"ic_schedule_normal",@"ic_schedule_select"];
    _tabBarView = [[STTabBarView alloc]initWithTitles:titles images:images];
    _tabBarView.hidden = YES;
    [_tabBarView setData:c05 SelectColor:c04 Font:[UIFont systemFontOfSize:STFont(14)]];
    [self addSubview:_tabBarView];
    
    WS(weakSelf)
    [_tabBarView getViewIndex:^(NSString *title, NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(index * ScreenWidth, 0);
        }];
    }];
    
    [_tabBarView setIndexBlock:^(NSString *title, NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(index * ScreenWidth, 0);
        }];
    }];
    
    [_tabBarView setViewIndex:mIndex];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(48))];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake([titles count]*ScreenWidth, 0);
    [self addSubview:_scrollView];
    
//    _infoView = [[InfoView alloc]init];
//    _infoView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(48));
//    [_scrollView addSubview:_infoView];
    
//    _scheduleView = [[ScheduleView alloc]initWithViewModel:_mScheduleViewModel];
//    _scheduleView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(48));
//    [_scrollView addSubview:_scheduleView];
    
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    [_tabBarView setViewIndex:index];
    if(_mViewModel){
        [_mViewModel changeTab:index];
    }
}





@end
