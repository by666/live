//
//  MainViewModel.m
//  live
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel


-(void)changeTab:(NSInteger)index{
    if(_delegate){
        [_delegate onChangeTab:index];
    }
}
@end
