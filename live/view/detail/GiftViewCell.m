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
@property (strong, nonatomic) UILabel *priceLabel;


@end

@implementation GiftViewCell{
    CGFloat width;
    CGFloat height;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        width = (ScreenWidth - STWidth(40))/3;
        height = width;
        [self initView];
        
    }
    return self;
}


-(void)initView{
    
    self.contentView.backgroundColor = cclear;
    
    _showImg = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(10), 0, width-STWidth(20), height-STHeight(20))];
    _showImg.layer.masksToBounds = YES;
    _showImg.layer.cornerRadius = STHeight(4);
    _showImg.backgroundColor = [cblack colorWithAlphaComponent:0.65f];
    _showImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_showImg];

 
    _priceLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _priceLabel.frame = CGRectMake(0, height-STHeight(20) , width, STHeight(14));
    [self.contentView addSubview:_priceLabel];

    
    
}

-(void)setData:(GiftModel *)model{
    [_showImg sd_setImageWithURL:[NSURL URLWithString:model.giftImageUrl]];
 
    _priceLabel.text = [NSString stringWithFormat:@"%d B币 x1",model.giftPrice];
}

+(NSString *)identify{
    return NSStringFromClass([GiftViewCell class]);
}

@end
