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
@property (strong, nonatomic) UIImageView *headImg;
@property (strong, nonatomic) UIView *bottomView;

@end

@implementation MainCell{
    CGFloat width;
    CGFloat height;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}


-(void)initView{

    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(60))];
    topView.backgroundColor = cwhite;
    [self.contentView addSubview:topView];
    
    
    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(10), STWidth(40), STWidth(40))];
    _headImg.layer.masksToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.layer.cornerRadius = STWidth(20);
    [self.contentView addSubview:_headImg];
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c01 backgroundColor:nil multiLine:NO];
    _titleLabel.frame = CGRectMake(STWidth(65) , STHeight(10) , ScreenWidth, STHeight(14));
    [topView addSubview:_titleLabel];
    
    
    UIImageView *cityImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(65), STHeight(32), STHeight(15), STHeight(15))];
    cityImageView.image = [UIImage imageNamed:@"ic_position"];
    [topView addSubview:cityImageView];
    
    _cityLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:cblack backgroundColor:nil multiLine:NO];
    [topView addSubview:_cityLabel];
    
    _userCountLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"" textAlignment:NSTextAlignmentCenter textColor:c02 backgroundColor:nil multiLine:NO];
    [topView addSubview:_userCountLabel];
    
    
    _showImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, STHeight(60), ScreenWidth, ScreenWidth*3/4)];
    _showImg.layer.masksToBounds = YES;
    _showImg.backgroundColor = cwhite;
    _showImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_showImg];
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(60) + ScreenWidth*3/4, ScreenWidth, STHeight(40))];
    _bottomView.backgroundColor = cwhite;
    [self.contentView addSubview:_bottomView];
    
    UILabel *liveStatuLabel =  [[UILabel alloc]initWithFont:STFont(14) text:@"直播中" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    liveStatuLabel.layer.masksToBounds = YES;
    liveStatuLabel.layer.cornerRadius = STHeight(8);
    liveStatuLabel.layer.borderWidth = LineHeight;
    liveStatuLabel.layer.borderColor = cwhite.CGColor;
    liveStatuLabel.frame = CGRectMake(ScreenWidth - STWidth(70), STHeight(15), STWidth(60), STHeight(20));
    liveStatuLabel.layer.shadowOffset = CGSizeMake(1, 1);
    liveStatuLabel.layer.shadowOpacity = 0.8;
    liveStatuLabel.layer.shadowColor = cblack.CGColor;
    [_showImg addSubview:liveStatuLabel];
    
   
}

-(void)setData:(MainModel *)model{
    
    _titleLabel.text = model.presenter_name;
    
    NSString *cityStr = model.presenter_city;
    if(IS_NS_STRING_EMPTY(cityStr)){
        cityStr = @"深圳市";
    }
    CGSize citySize = [cityStr sizeWithMaxWidth:width font:[UIFont systemFontOfSize:STFont(14)]];
    _cityLabel.frame = CGRectMake(STWidth(80),STHeight(32), citySize.width, STHeight(14));
    _cityLabel.text = cityStr;

    NSString *countStr = [NSString stringWithFormat:@"%ld人观看",model.total_view];
    CGSize countSize = [countStr sizeWithMaxWidth:width font:[UIFont systemFontOfSize:STFont(12)]];
    _userCountLabel.frame = CGRectMake(ScreenWidth - STWidth(15) - countSize.width, 0, countSize.width, STHeight(60));
    _userCountLabel.text = countStr;

    [_headImg sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    [_showImg sd_setImageWithURL:[NSURL URLWithString:model.cover_url]];
    
    NSArray *labels = [model.tags componentsSeparatedByString:@","];
    CGFloat left = 0;
    for(int i = 0 ; i < labels.count ; i++){
        UILabel *labelView = [[UILabel alloc]initWithFont:STFont(12) text:labels[i] textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c02 multiLine:NO];
        CGSize labelSize = [labels[i] sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(12)]];
        labelView.frame = CGRectMake(STWidth(15) + left, STHeight(10),labelSize.width + STWidth(20) ,STHeight(20));
        labelView.layer.masksToBounds = YES;
        labelView.layer.cornerRadius = STHeight(10);
        [_bottomView addSubview:labelView];
        left += (labelSize.width + STWidth(30));
    }
    
}

+(NSString *)identify{
    return NSStringFromClass([MainCell class]);
}

@end
