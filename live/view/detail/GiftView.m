//
//  GiftView.m
//  live
//
//  Created by 黄成实 on 2018/6/26.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "GiftView.h"

@interface GiftView()

@property(strong, nonatomic)DetailViewModel *mViewModel;

@end

@implementation GiftView

-(instancetype)initWithViewModel:(DetailViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = c03;
}
@end
