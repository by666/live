//
//  MineViewCell.m
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MineViewCell.h"

@interface MineViewCell()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *contentLabel;
@property(strong, nonatomic)UIImageView *arrowImageView;
@property(strong, nonatomic)UIView *lineView;

@end

@implementation MineViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:nil textAlignment:NSTextAlignmentCenter textColor:cblack backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(16) text:nil textAlignment:NSTextAlignmentCenter textColor:c01 backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_contentLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.frame = CGRectMake(STWidth(30),STHeight(54) -LineHeight , ScreenWidth - STWidth(15), LineHeight);
    _lineView.backgroundColor = cline;
    [self.contentView addSubview:_lineView];
    
    _arrowImageView = [[UIImageView alloc]init];
    _arrowImageView.image = [UIImage imageNamed:@"ic_arrow_right"];
    _arrowImageView.frame = CGRectMake(STWidth(354), STHeight(21), STWidth(7), STHeight(11));
    [self.contentView addSubview:_arrowImageView];
    
    
}

-(void)updateData:(TitleContentModel *)model showLine:(Boolean)showLine{
    CGSize titleSize = [model.title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _titleLabel.text = model.title;
    _titleLabel.frame = CGRectMake(STWidth(30), 0, titleSize.width, STHeight(54));
    
    if(!IS_NS_STRING_EMPTY(model.content)){
        CGSize contentSize = [model.content sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        _contentLabel.text = model.content;
        _contentLabel.frame = CGRectMake(ScreenWidth - STWidth(30) - contentSize.width, 0, contentSize.width, STHeight(54));
    }


    _lineView.hidden = !showLine;
}

+(NSString *)identify{
    return NSStringFromClass([MineViewCell class]);
}

@end
