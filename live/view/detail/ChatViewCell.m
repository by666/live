//
//  ChatViewCell.m
//  live
//
//  Created by 黄成实 on 2018/7/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ChatViewCell.h"

@interface ChatViewCell()

@property(copy, nonatomic)UILabel *contentLabel;

@end

@implementation ChatViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:cblack backgroundColor:nil multiLine:YES];
    [self.contentView addSubview:_contentLabel];
}


-(void)updateView:(ChatModel *)chatModel{
    if(chatModel.identify == CI_System){
        _contentLabel.textColor = c01;
    }else if(chatModel.identify == CI_Mine){
        _contentLabel.textColor = c01;
    }else{
        _contentLabel.textColor = cblack;
    }
    NSString *contentStr = [NSString stringWithFormat:@"%@：%@",chatModel.name,chatModel.content];
    CGSize contentSize = [contentStr sizeWithMaxWidth:ScreenWidth - STWidth(20) font:[UIFont systemFontOfSize:STFont(14)]];
    _contentLabel.frame = CGRectMake(STWidth(10), STHeight(5), ScreenWidth -  STWidth(20), contentSize.height);
    _contentLabel.text = contentStr;
    
}


+(NSString *)identify{
    return NSStringFromClass([ChatViewCell class]);
}

@end
