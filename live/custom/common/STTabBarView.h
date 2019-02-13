#import <UIKit/UIKit.h>


@protocol STTabBarViewDelegate <NSObject>

-(void)onTabBarSelected:(NSInteger)index;

@end

@interface STTabBarView : UIView

@property(weak, nonatomic)id<STTabBarViewDelegate> delegate;
-(instancetype)initWithTitles:(NSArray *)titles centerBtn:(Boolean)hidden;

@end
