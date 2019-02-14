//
//  STDouYinScroll.m
//  live
//
//  Created by by.huang on 2019/2/14.
//  Copyright © 2019 黄成实. All rights reserved.
//

#import "STDouYinScrollView.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "STPlayerView.h"
#import "STConvertUtil.h"
#import "VideoModel.h"

@interface STDouYinScrollView()<UIScrollViewDelegate>

@property(strong, nonatomic)NSMutableArray *mDatas;
@property(strong, nonatomic)STPlayerView *currentView;
@property(strong, nonatomic)NSMutableArray *mViews;

@end

@implementation STDouYinScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initSetting];
    self.delegate = self;
    [self parseData];
    self.contentSize = CGSizeMake(ScreenWidth, ScreenHeight * _mDatas.count);
    _mViews = [[NSMutableArray alloc]init];
    for(int i = 0 ; i < _mDatas.count; i++){
        VideoModel *model = [_mDatas objectAtIndex:i];
        STPlayerView *view = [[STPlayerView alloc]initWithUrl:model.video_url];
        view.backgroundColor = cblack;
        [self addSubview:view];
        if(i == 0){
            [view startPlay:0];
            _currentView = view;
        }
        [_mViews addObject:view];
    }

}

-(void)parseData{
    _mDatas = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"source" ofType:@"json"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic = [STConvertUtil jsonToDic:content];
    id data = [dic objectForKey:@"data"];
    NSMutableArray *datas = [VideoModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"video_list"]];
    for(VideoModel *model in datas){
        [_mDatas addObject:model];
    }
}

-(void)initSetting{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;

    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.mj_offsetY;
    [STLog print:[NSString stringWithFormat:@"%.f",offsetY]];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat y =  scrollView.mj_offsetY;
    NSInteger current =  y / ScreenHeight;
    [self handlePage:current];
}

-(void)handlePage:(NSInteger)pageIndex{
    [_currentView stopPlay];
    STPlayerView *view = [_mViews objectAtIndex:pageIndex];
    [view startPlay:pageIndex];
    [STLog print:@"当前页:" content:[NSString stringWithFormat:@"%ld",pageIndex]];
    _currentView = view;
}




@end
