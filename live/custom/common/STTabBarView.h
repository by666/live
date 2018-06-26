#import <UIKit/UIKit.h>

typedef void (^IndexBlock)(NSString *title,NSInteger index);

@interface STTabBarView : UIView

@property (nonatomic, strong) UIColor    *lineColor;
@property (nonatomic, assign) CGFloat    lineHeight;
@property (nonatomic, assign) CGFloat    lineCornerRadius;
@property (nonatomic, copy  ) IndexBlock indexBlock;


-(instancetype)initWithTitles:(NSArray *)titles;
-(void)setData:(UIColor *)normal_color SelectColor:(UIColor *)select_color Font:(UIFont *)font;
-(void)getViewIndex:(IndexBlock)block;
-(void)setViewIndex:(NSInteger)index;

@end
