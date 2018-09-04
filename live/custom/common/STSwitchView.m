//
//  STSwitchView.m
//  framework
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STSwitchView.h"

@interface STSwitchView()

@property(strong, nonatomic)UIView *pointView;

@end

@implementation STSwitchView

-(instancetype)init{
    if(self == [super init]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, STWidth(42), STHeight(26));
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = STHeight(13);
    self.backgroundColor = c01;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTouchSwitchView)];
    [self addGestureRecognizer:recognizer];
    
    _pointView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(2), STHeight(2), STHeight(22), STHeight(22))];
    _pointView.backgroundColor = cwhite;
    _pointView.layer.masksToBounds = YES;
    _pointView.layer.cornerRadius = STHeight(11);
    [self addSubview:_pointView];
    
    [self setOn:_on];
    
}


-(void)onTouchSwitchView{
    WS(weakSelf)
    if(_on){
        [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            weakSelf.pointView.frame = CGRectMake(STWidth(2), STHeight(2), STHeight(22), STHeight(22));
            weakSelf.backgroundColor = c02;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            weakSelf.pointView.frame = CGRectMake(STWidth(18), STHeight(2), STHeight(22), STHeight(22));
            weakSelf.backgroundColor = c01;
        } completion:^(BOOL finished) {
            
        }];
    }
    _on = !_on;
    if(_delegate){
        [_delegate onSwitchStatuChange:_on];
    }
}


-(void)setOn:(Boolean)on{
    _on = on;
    if(_on){
        _pointView.frame = CGRectMake(STWidth(18), STHeight(2), STHeight(22), STHeight(22));
        self.backgroundColor = c02;
    }else{
        _pointView.frame = CGRectMake(STWidth(2), STHeight(2), STHeight(22), STHeight(22));
        self.backgroundColor = c01;
    }
}


@end
