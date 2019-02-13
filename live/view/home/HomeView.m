//
//  HomeView.m
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "HomeView.h"

@interface HomeView()
    
    @property(strong, nonatomic)HomeViewModel *mViewModel;
    
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
    
}
    
-(void)updateView{
    
}
    
    @end

