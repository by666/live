//
//  ChatViewCell.m
//  live
//
//  Created by 黄成实 on 2018/7/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ChatViewCell.h"

@interface ChatViewCell()

@property(copy, nonatomic)UILabel *nameLabel;
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
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:cblack backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_nameLabel];
    
    _contentLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:cblack backgroundColor:nil multiLine:NO];
    [self.contentView addSubview:_contentLabel];
}


-(void)updateView:(ChatModel *)chatModel{
    if(chatModel.identify == CI_System){
        _nameLabel.textColor = c0
    }
}


+(NSString *)identify{
    return NSStringFromClass([ChatViewCell class]);
}

@end
