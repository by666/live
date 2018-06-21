#import "STTabBarView.h"

@interface STTabBarView()

@property (nonatomic, strong) NSArray *mTitles;
@property (nonatomic, strong) NSArray *mImages;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation STTabBarView



- (instancetype)initWithTitles:(NSArray *)titles images:(NSArray *)images
{
    self = [super init];
    if (self) {
        _mTitles = titles;
        _mImages = images;
        self.frame = CGRectMake(0, ContentHeight - STHeight(48), ScreenWidth, STHeight(48));
        self.backgroundColor = cwhite;
    }
    return self;
}


- (void)setData:(UIColor *)normal_color SelectColor:(UIColor *)select_color Font:(UIFont *)font{
    
    CGFloat width = ScreenWidth / _mTitles.count;
    
    for (int i=0; i<_mTitles.count; i++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(i * width, 0, width, STHeight(48));
        [item setTitle:_mTitles[i] forState:UIControlStateNormal];
        [item setTitleColor:normal_color forState:UIControlStateNormal];
        [item setTitleColor:select_color forState:UIControlStateSelected];
        [item setImage:[UIImage imageNamed:_mImages[i * 2]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:_mImages[i * 2 + 1]] forState:UIControlStateSelected];
        item.titleLabel.font = font;
        item.tag = i + 10;
        item.titleEdgeInsets = UIEdgeInsetsMake(item.imageView.frame.size.height+STHeight(5), -item.imageView.frame.size.width, 0, 0);
        item.imageEdgeInsets = UIEdgeInsetsMake(-item.titleLabel.bounds.size.height- STHeight(5),  0,  0, -item.titleLabel.bounds.size.width);
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
 
    }
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, LineHeight)];
    self.lineView.backgroundColor = c07;
    [self addSubview:self.lineView];
    
}

- (void)clickItem:(UIButton *)button{
    
    [self setAnimation:button.tag-10];
    
    if (self.indexBlock != nil) {
        self.indexBlock(_mTitles[button.tag-10],button.tag-10);
    }
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
    
}


@end
