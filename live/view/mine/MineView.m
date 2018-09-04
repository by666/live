//
//  MineView.m
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MineView.h"
#import "MineViewCell.h"
#import "STUserDefaults.h"

@interface MineView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)MineViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;

@end


@implementation MineView

-(instancetype)initWithViewModel:(MineViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    [self initTopView];
    [self initTableView];
}

-(void)initTopView{
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, 0, ScreenWidth, STHeight(160));
    topView.backgroundColor = cwhite;
    [self addSubview:topView];
    
    CGFloat imageSize = STHeight(80);
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - imageSize )/2, STHeight(20), imageSize, imageSize)];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = imageSize/2;
    headImageView.image = [UIImage imageNamed:@"icon"];
    [self addSubview:headImageView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(160)-LineHeight, ScreenWidth , LineHeight)];
    lineView.backgroundColor = cline;
    [self addSubview:lineView];
    
    NSString *uid = [STUserDefaults getKeyValue:UD_ID];

    UILabel *accountLabel = [[UILabel alloc]initWithFont:STFont(16) text:uid textAlignment:NSTextAlignmentCenter textColor:c01 backgroundColor:nil multiLine:NO];
    accountLabel.frame = CGRectMake(0, STHeight(120), ScreenWidth, STHeight(16));
    [self addSubview:accountLabel];
}


-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(170), ScreenWidth, STHeight(54) * [_mViewModel.datas count])];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = cwhite;
    [_tableView useDefaultProperty];
    [self addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(54);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MineViewCell identify]];
    if(!cell){
        cell = [[MineViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MineViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    TitleContentModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    if(indexPath.row == [_mViewModel.datas count] - 1){
        [cell updateData:model showLine:NO];
    }else{
        [cell updateData:model showLine:YES];
    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_mViewModel){
        NSInteger row = indexPath.row;
        switch (row) {
            case 0:
                [_mViewModel openRewardAd];
                break;
            case 1:
                [_mViewModel goAgreementPage];
                break;
            case 2:
                [_mViewModel goDisclaimerPage];
                break;
            case 3:
                [_mViewModel goAboutPage];
                break;
            default:
                break;
        }
    }
}

-(void)updateView{
    [_tableView reloadData];
}

@end
