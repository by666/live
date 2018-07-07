//
//  GiftViewCell.m
//  live
//
//  Created by 黄成实 on 2018/7/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "GiftViewCell.h"

@interface GiftViewCell()

@property (strong, nonatomic) UIImageView *showImg;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *userCountLabel;
@property (strong, nonatomic) UILabel *cityLabel;

@end

@implementation GiftViewCell{
    CGFloat width;
    CGFloat height;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        width = (ScreenWidth - STWidth(60))/3;
        height = width;
        [self initView];
        
    }
    return self;
}


-(void)initView{

    self.backgroundColor = c01;
//    _showImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
//    _showImg.layer.masksToBounds = YES;
//    _showImg.backgroundColor = cwhite;
//    CAShapeLayer *topLayer = [[CAShapeLayer alloc] init];
//    topLayer.frame = _showImg.bounds;
//    topLayer.path =  [UIBezierPath bezierPathWithRoundedRect:_showImg.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(STHeight(6), STHeight(6))].CGPath;
//    _showImg.layer.mask = topLayer;
//    _showImg.contentMode = UIViewContentModeScaleAspectFill;
//    [self.contentView addSubview:_showImg];
//
 
    
    
    
}

-(void)setData:(GiftModel *)model{
    
 
}

+(NSString *)identify{
    return NSStringFromClass([GiftViewCell class]);
}

@end
