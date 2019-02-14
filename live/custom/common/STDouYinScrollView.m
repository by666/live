//
//  STDouYinScroll.m
//  live
//
//  Created by by.huang on 2019/2/14.
//  Copyright © 2019 黄成实. All rights reserved.
//

#import "STDouYinScrollView.h"

@interface STDouYinScrollView()<UIScrollViewDelegate>

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
    self.contentSize = CGSizeMake(ScreenWidth, ScreenHeight * 10);
    for(int i = 0 ; i < 10; i++){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight * i, ScreenWidth, ScreenHeight)];
        view.backgroundColor = [STColorUtil colorWithHexString:[NSString stringWithFormat:@"#%d%d%d%d%d%d",i,i,i,i,i,i]];
        [self addSubview:view];
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
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

@end
