//
//  STNavigationView.m
//  framework
//
//  Created by 黄成实 on 2018/5/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STNavigationView.h"

@interface STNavigationView()


@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UIButton *backBtn;

@end

@implementation STNavigationView{
    NSString *mTitle;
    Boolean mNeedBack;
    NSString *mRightStr;
    UIColor *mRightColor;

}

-(instancetype)initWithTitle:(NSString *)title needBack:(Boolean)needBack{
    if(self == [super init]){
        mTitle = title;
        mNeedBack = needBack;
        [self initView];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title needBack:(Boolean)needBack rightBtn:(NSString *)rightStr{
    if(self == [super init]){
        mTitle = title;
        mNeedBack = needBack;
        mRightStr = rightStr;
        [self initView];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title needBack:(Boolean)needBack rightBtn:(NSString *)rightStr rightColor:(UIColor *)rightColor{
    if(self == [super init]){
        mTitle = title;
        mNeedBack = needBack;
        mRightStr = rightStr;
        mRightColor = rightColor;
        [self initView];
    }
    return self;
}


-(void)initView{
    self.backgroundColor = c03;
    self.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, NavigationBarHeight);
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(17) text:mTitle textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(0, 0, ScreenWidth, NavigationBarHeight);
    [self addSubview:_titleLabel];
    

    if(mNeedBack){
        _backBtn = [[UIButton alloc]init];
        UIImage *image = [UIImage imageNamed:@"ic_back"];
        [_backBtn setImage:image forState:UIControlStateNormal];
        _backBtn.frame = CGRectMake(0, 0, STWidth(30) + image.size.width,NavigationBarHeight);
        [_backBtn addTarget:self action:@selector(OnBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backBtn];
    }
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, NavigationBarHeight - LineHeight, ScreenWidth, LineHeight);
    lineView.backgroundColor = c01;
    [self addSubview:lineView];
    
    if(!IS_NS_STRING_EMPTY(mRightStr)){
        if(mRightColor == nil){
            mRightColor = c01;
        }

        UIButton *button = [[UIButton alloc]initWithFont:STFont(14) text:mRightStr textColor:mRightColor backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
        button.frame = CGRectMake(ScreenWidth - button.titleLabel.contentSize.width - STWidth(20) , 0, button.titleLabel.contentSize.width + STWidth(20), NavigationBarHeight);
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(onClickRightBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
      
    }

   
}


-(void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}

-(void)OnBackBtnClick{
    if(_delegate && [_delegate respondsToSelector:@selector(OnBackBtnClicked)]){
        [_delegate OnBackBtnClicked];
    }
}

-(void)onClickRightBtn{
    if(_delegate && [_delegate respondsToSelector:@selector(onRightBtnClicked)]){
        [_delegate onRightBtnClicked];
    }
}

@end
