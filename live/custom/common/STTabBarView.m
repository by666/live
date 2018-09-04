#import "STTabBarView.h"

@interface STTabBarView()

@property (nonatomic, strong) NSArray *mTitles;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation STTabBarView



- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        _mTitles = titles;
        self.frame = CGRectMake(0, ScreenWidth * 3 / 4, ScreenWidth, STHeight(44));
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)setData:(UIColor *)normal_color SelectColor:(UIColor *)select_color Font:(UIFont *)font{
    
    CGFloat width = ScreenWidth / _mTitles.count;
    
    for (int i=0; i<_mTitles.count; i++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(i * width, 0, width, STHeight(44));
        [item setTitle:_mTitles[i] forState:UIControlStateNormal];
        [item setTitleColor:normal_color forState:UIControlStateNormal];
        [item setTitleColor:select_color forState:UIControlStateSelected];
        item.titleLabel.font = font;
        item.tag = i + 10;
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        
        if (i == 0) {
            
            item.selected = YES;
            self.selectedBtn = item;
            self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 3, width, 3)];
            self.lineView.layer.cornerRadius = 3.0;
            self.lineView.backgroundColor = cline;
            self.lineView.layer.masksToBounds = YES;
            [self addSubview:self.lineView];
        }
    }
    
}

- (void)clickItem:(UIButton *)button{
    
    [self setAnimation:button.tag-10];
    
    if (self.indexBlock != nil) {
        self.indexBlock(_mTitles[button.tag-10],button.tag-10);
    }
}


- (void)setLineColor:(UIColor *)lineColor{
    self.lineView.backgroundColor = lineColor;
}

- (void)setLineHeight:(CGFloat)lineHeight{
    CGRect frame = self.lineView.frame;
    frame.size.height = lineHeight;
    frame.origin.y = CGRectGetHeight(self.frame) - lineHeight;
    self.lineView.frame = frame;
}

- (void)setLineCornerRadius:(CGFloat)lineCornerRadius{
    self.lineView.layer.cornerRadius = lineCornerRadius;
}


- (void)getViewIndex:(IndexBlock)block{
    self.indexBlock = block;
}


- (void)setViewIndex:(NSInteger)index{
    if (index < 0) {
        index = 0;
    }
    
    if (index > _mTitles.count - 1) {
        index = _mTitles.count - 1;
    }
    
    [self setAnimation:index];
}


- (void)setAnimation:(NSInteger)index{
    
    UIButton *tempBtn = (UIButton *)[self viewWithTag:index+10];
    self.selectedBtn.selected = NO;
    tempBtn.selected = YES;
    self.selectedBtn = tempBtn;
    
    CGFloat x = index * (ScreenWidth / _mTitles.count);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.lineView.frame;
        frame.origin.x = x;
        self.lineView.frame = frame;
    }];
}


@end
