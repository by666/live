#import "STTabBarView.h"

@interface STTabBarView()

@property (strong,nonatomic)NSArray *mTitles;
@property (assign,nonatomic)Boolean mCenterHidden;
@property (strong,nonatomic)UIButton *addBtn;
@property (strong,nonatomic)UIView *lineView;

@end

@implementation STTabBarView{
    CGFloat TabBarHeight;
    UIButton *selectBtn;
}

- (instancetype)initWithTitles:(NSArray *)titles centerBtn:(Boolean)hidden{
    if (self == [super init]) {
        _mTitles = titles;
        _mCenterHidden = hidden;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initContentView];
    [self initTitlesView];
}

-(void)initContentView{
    CGFloat homeHeight = 0;
    if (@available(iOS 11.0, *)) {
        homeHeight = HomeIndicatorHeight;
    } else {
        homeHeight = 0;
    }
    TabBarHeight = STHeight(44) + homeHeight;
    self.frame = CGRectMake(0, ScreenHeight - TabBarHeight, ScreenWidth, TabBarHeight);
    self.backgroundColor = c15;
}

-(void)initTitlesView{
    NSInteger count = [_mTitles count];
    CGFloat perWidth = ScreenWidth / 5;
    for(int i = 0; i< count ; i ++){
        UIButton *labelBtn = [[UIButton alloc]initWithFont:STFont(14) text:_mTitles[i] textColor:cwhite backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
        labelBtn.tag = i;
        [labelBtn addTarget:self action:@selector(onLabelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0){
            selectBtn = labelBtn;
            [labelBtn setTitleColor:cwhite forState:UIControlStateNormal];
            [labelBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:STFont(16)]];
        }else{
            [labelBtn setTitleColor:c03 forState:UIControlStateNormal];
            [labelBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:STFont(14)]];
        }
        if(i > 1){
            labelBtn.frame = CGRectMake(perWidth * (i+1), 0, perWidth, STHeight(44));
        }else{
            labelBtn.frame = CGRectMake(perWidth * i, 0, perWidth, STHeight(44));
        }
        [self addSubview:labelBtn];
    }
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(perWidth/4, STHeight(44)-LineHeight*2, perWidth/2, LineHeight*2)];
    _lineView.backgroundColor = cwhite;
    [self addSubview:_lineView];
    
    _addBtn = [[UIButton alloc]init];
    [_addBtn setImage:[UIImage imageNamed:@"live"] forState:UIControlStateNormal];
    _addBtn.frame = CGRectMake(perWidth*2 + (perWidth - STHeight(40))/2 ,0, STHeight(40), STHeight(40));
    [_addBtn addTarget:self action:@selector(onAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];

}

-(void)onLabelBtnClicked:(id)sender{
    CGFloat perWidth = ScreenWidth / 5;
    UIButton *btn = ((UIButton *)sender);
    NSInteger tag = btn.tag;
    WS(weakSelf)
    [UIView animateWithDuration:0.3f animations:^{
        [btn setTitleColor:cwhite forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:STFont(16)]];
        [self->selectBtn setTitleColor:c03 forState:UIControlStateNormal];
        [self->selectBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:STFont(14)]];
        self->selectBtn = btn;
        if(tag > 1){
            weakSelf.lineView.frame = CGRectMake((tag+1) *perWidth + perWidth/4, STHeight(44)-LineHeight*2, perWidth/2, LineHeight*2);
        }else{
            weakSelf.lineView.frame = CGRectMake(tag *perWidth + perWidth/4, STHeight(44)-LineHeight*2, perWidth/2, LineHeight*2);
        }
    }];
}

-(void)onAddBtnClick{
    
}



@end
