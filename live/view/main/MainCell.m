//
//  MainCell.m
//  framework
//
//  Created by 黄成实 on 2018/6/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainCell.h"

@interface MainCell()

@property (strong, nonatomic) UIImageView *showImg;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *userCountLabel;
@property (strong, nonatomic) UILabel *cityLabel;

@end

@implementation MainCell{
    CGFloat width;
    CGFloat height;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        width = (ScreenWidth - STWidth(30))/2;
        height = width * 4 / 3;
        [self initView];
    
    }
    return self;
}


-(void)initView{
    
    _showImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    _showImg.layer.masksToBounds = YES;
    _showImg.backgroundColor = cwhite;
    CAShapeLayer *topLayer = [[CAShapeLayer alloc] init];
    topLayer.frame = _showImg.bounds;
    topLayer.path =  [UIBezierPath bezierPathWithRoundedRect:_showImg.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(STHeight(6), STHeight(6))].CGPath;
    _showImg.layer.mask = topLayer;
    _showImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_showImg];
    

    UIView *txtView = [[UIView alloc]initWithFrame:CGRectMake(0, height, width, STHeight(50))];
    txtView.backgroundColor = cwhite;
    [self.contentView addSubview:txtView];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:cblack backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(STWidth(10) , 0 , width - STWidth(20), STHeight(25));
    [txtView addSubview:_titleLabel];
    
    
    UIImageView *cityImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(10), STHeight(25), STHeight(20), STHeight(20))];
    cityImageView.image = [UIImage imageNamed:@"ic_position"];
    [txtView addSubview:cityImageView];
    
    _cityLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:c01 backgroundColor:nil multiLine:NO];
    [txtView addSubview:_cityLabel];
    
    _userCountLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"" textAlignment:NSTextAlignmentCenter textColor:c01 backgroundColor:nil multiLine:NO];
    [txtView addSubview:_userCountLabel];
    
    
   
}

-(void)setData:(MainModel *)model{
    
    _titleLabel.text = model.nick;
    
    NSString *cityStr = model.city;
    if(IS_NS_STRING_EMPTY(cityStr)){
        cityStr = @"地球";
    }
    CGSize citySize = [cityStr sizeWithMaxWidth:width font:[UIFont systemFontOfSize:STFont(14)]];
    _cityLabel.frame = CGRectMake(STWidth(34),STHeight(22), citySize.width, STHeight(25));
    _cityLabel.text = cityStr;

    NSString *countStr = [NSString stringWithFormat:@"%d人观看",arc4random() % 1000];
    CGSize countSize = [countStr sizeWithMaxWidth:width font:[UIFont systemFontOfSize:STFont(12)]];
    _userCountLabel.frame = CGRectMake(width - STWidth(10) - countSize.width, STHeight(23), countSize.width, STHeight(25));
    _userCountLabel.text = countStr;

    [_showImg sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
}

+(NSString *)identify{
    return NSStringFromClass([MainCell class]);
}

@end
