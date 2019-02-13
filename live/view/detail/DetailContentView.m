//
//  DetailContentView.m
//  live
//
//  Created by 黄成实 on 2018/6/26.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DetailContentView.h"
#import "ChatViewCell.h"
#import "GiftView.h"
#import "STUserDefaults.h"

@interface DetailContentView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)DetailViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIView *bottomView;


@end

@implementation DetailContentView

-(instancetype)initWithViewModel:(DetailViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    CGFloat tableHeight =  ScreenHeight - VideoHeight - STHeight(44);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, tableHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = cwhite;
    [_tableView useDefaultProperty];
    [self addSubview:_tableView];

    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, tableHeight, ScreenWidth, STHeight(44))];
    [self addSubview:_bottomView];
    
    [self buildBottomView];
}

-(void)buildBottomView{
    
    CGFloat btnHeight = STHeight(44);
    
    UIButton *giftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, btnHeight)];
    [giftBtn setImage:[UIImage imageNamed:@"ic_gift"] forState:UIControlStateNormal];
    [giftBtn addTarget:self action:@selector(onClickGiftBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:giftBtn];
    
    UIButton *chatBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, btnHeight)];
    [chatBtn setImage:[UIImage imageNamed:@"ic_chat"] forState:UIControlStateNormal];
    [chatBtn addTarget:self action:@selector(onClickChatBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:chatBtn];
    
    
    UIButton *reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth * 2/3, 0, ScreenWidth/3, btnHeight)];
    [reportBtn setImage:[UIImage imageNamed:@"ic_report"] forState:  UIControlStateNormal];
    [reportBtn addTarget:self action:@selector(onClickReportBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:reportBtn];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.chatDatas)){
        return [_mViewModel.chatDatas count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.chatDatas)){
        ChatModel *chatModel = [_mViewModel.chatDatas objectAtIndex:indexPath.row];
        NSString *content = [NSString stringWithFormat:@"%@：%@",chatModel.name,chatModel.content];
        CGSize cellSize = [content sizeWithMaxWidth:(ScreenWidth - STWidth(20)) font:[UIFont systemFontOfSize:STFont(14)]];
        return cellSize.height + STHeight(5);
    }
    return STHeight(30);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChatViewCell identify]];
    if(!cell){
        cell = [[ChatViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ChatViewCell identify]];
    }
    [cell setBackgroundColor:cclear];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!IS_NS_COLLECTION_EMPTY(_mViewModel.chatDatas)){
        [cell updateView:[_mViewModel.chatDatas objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)onClickChatBtn{
    if(_mViewModel){
        [_mViewModel openChat];
    }
}

-(void)onClickGiftBtn{
    if(_mViewModel){
        [_mViewModel hideGiftView:NO];
    }
}

-(void)onClickReportBtn{
    if(_mViewModel){
        [_mViewModel report];
    }
}


-(void)updateView{
    [_tableView reloadData];
}

@end
