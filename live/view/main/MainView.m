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

@interface MainView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong, nonatomic)MainViewModel *mViewModel;
@property(strong, nonatomic)UICollectionView *collectionView;


@end

@implementation MainView

-(instancetype)initWithViewModel:(MainViewModel *)viewModel {
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = cwhite;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[MainCell class] forCellWithReuseIdentifier:[MainCell identify]];
    
    if(_mViewModel){
        [_mViewModel requestData];
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_mViewModel.datas count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainCell identify] forIndexPath:indexPath];
    if(_mViewModel && !IS_NS_COLLECTION_EMPTY(_mViewModel.datas)){
        MainModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
        [cell setData:model];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView  layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake(ScreenWidth/3, ScreenWidth/3 + STHeight(30));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0 , 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_mViewModel){
    
    }
    
}



-(void)updateView{
    [_collectionView reloadData];
}




@end
