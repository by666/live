//
//  STTopTabView.m
//  live
//
//  Created by by.huang on 2019/2/14.
//  Copyright © 2019 黄成实. All rights reserved.
//

#import "STTopTabView.h"

@interface STTopTabView()

@property(strong, nonatomic)NSArray *mTitles;
@property(strong, nonatomic)UIButton *selectBtn;

@end

@implementation STTopTabView

-(instancetype)initWithTitles:(NSArray *)titles{
    if(self == [super init]){
        _mTitles = titles;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, STHeight(15) + StatuBarHeight, ScreenWidth, STHeight(30));
    
    if(!IS_NS_COLLECTION_EMPTY(_mTitles)){
        for(int i = 0 ; i < _mTitles.count ; i ++){
            UIButton *tabBtn = [[UIButton alloc]initWithFont:STFont(16) text:_mTitles[i] textColor:cwhite backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
            [tabBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:STFont(16)]];
            [tabBtn setTitleColor:c05 forState:UIControlStateHighlighted];
            if(i == 0){
                _selectBtn = tabBtn;
                [tabBtn setTitleColor:cwhite forState:UIControlStateNormal];
                tabBtn.frame = CGRectMake(ScreenWidth/2 - STWidth(60),0, STWidth(60), STHeight(30));
            }else{
                [tabBtn setTitleColor:c05 forState:UIControlStateNormal];
                tabBtn.frame = CGRectMake(ScreenWidth/2 ,0, STWidth(60), STHeight(30));
            }
            tabBtn.tag = i;
            [tabBtn addTarget:self action:@selector(onTabBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:tabBtn];
            
        }
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2, STHeight(10), 1, STHeight(10))];
    lineView.backgroundColor = cline;
    [self addSubview:lineView];
}


-(void)onTabBtnClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    [_selectBtn setTitleColor:c05 forState:UIControlStateNormal];
    [btn setTitleColor:cwhite forState:UIControlStateNormal];
    _selectBtn = btn;
    if(_delegate){
       [_delegate onTopTabSelected:tag];
    }
}


@end
