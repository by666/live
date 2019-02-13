//
//  MainView.m
//  live
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainView.h"
#import "STTabBarView.h"
#import "MainCell.h"

@interface MainView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)HomeViewModel *mViewModel;
@property(strong, nonatomic)UITableView *tableView;


@end

@implementation MainView

-(instancetype)initWithViewModel:(HomeViewModel *)viewModel {
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
   
    

    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_mViewModel.datas count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return STHeight(4);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc]init];
    sectionView.backgroundColor = c05;
    return sectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(100) + ScreenWidth * 3 /4;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:[MainCell identify]];
    if(!cell){
        cell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MainCell identify]];
    }
    if(_mViewModel && !IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        MainModel *model = [_mViewModel.datas objectAtIndex:indexPath.section];
        [cell setData:model];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(_mViewModel){
//        [_mViewModel goDetailPage: [_mViewModel.datas objectAtIndex:indexPath.section]];
    }
    
}



-(void)updateView{
    [_tableView reloadData];
}




@end
