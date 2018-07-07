//
//  GiftView.m
//  live
//
//  Created by 黄成实 on 2018/7/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "GiftView.h"
#import "GiftViewCell.h"
#define GiftHeight (STWidth(255) + STHeight(44))

@interface GiftView()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong, nonatomic)NSMutableArray *datas;
@property(strong ,nonatomic)UIView *contentView;
@property(strong, nonatomic)UIScrollView *scrollView;

@end

@implementation GiftView{
    NSInteger count;
}

-(instancetype)initWithDatas:(NSMutableArray *)datas{
    if(self == [super init]){
        _datas = datas;
        [self initView];
    }
    return self;
}

-(void)initView{

    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = [cblack colorWithAlphaComponent:0.65f];
    self.hidden =YES;
    
    if(!IS_NS_COLLECTION_EMPTY(_datas)){
        NSInteger tempcount = [_datas count];
        if(tempcount % 6 == 0){
            count = tempcount / 6;
        }else{
            count = tempcount / 6 + 1;
        }
    }
    _contentView = [[UIView alloc]init];
    _contentView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, GiftHeight);
    _contentView.backgroundColor = [c18 colorWithAlphaComponent:0.8f];
    _contentView.userInteractionEnabled = YES;
    [self addSubview:_contentView];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, GiftHeight - STHeight(44))];
    _scrollView.backgroundColor = cwhite;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(ScreenWidth * count, GiftHeight - STHeight(44));
    [_contentView addSubview:_scrollView];


    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    if(count > 0){
        for(int i = 0 ; i < count ; i ++){
            
            UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, GiftHeight - STHeight(44)) collectionViewLayout:layout];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.backgroundColor = c15;
            collectionView.scrollEnabled = NO;
            collectionView.tag = i;
            [_scrollView addSubview:collectionView];
            
            [collectionView registerClass:[GiftViewCell class] forCellWithReuseIdentifier:[GiftViewCell identify]];
            
        }
    }
}


-(void)hideGiftView:(Boolean)hidden{
    WS(weakSelf)
    if(hidden){
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.contentView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, GiftHeight);
        } completion:^(BOOL finished) {
            weakSelf.hidden = YES;
        }];
    }else{
        self.hidden = NO;
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.contentView.frame = CGRectMake(0, ScreenHeight - GiftHeight, ScreenWidth, GiftHeight);
        }];
    }
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(collectionView.tag == count - 1){
        return [_datas count] % 6;
    }
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tag = collectionView.tag;
    GiftViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GiftViewCell identify] forIndexPath:indexPath];
    if(_datas && !IS_NS_COLLECTION_EMPTY(_datas)){
        
        GiftModel *model = [_datas objectAtIndex:0];
        [cell setData:model];
    }
    [STLog print:@"collection" content:[NSString stringWithFormat:@"%ld",tag]];
    [STLog print:@"index" content:[NSString stringWithFormat:@"%ld",indexPath.row + 6 * tag]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView  layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CGFloat width = (ScreenWidth - STWidth(60))/3;
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return STWidth(15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return STWidth(15);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideGiftView:YES];
}

@end
