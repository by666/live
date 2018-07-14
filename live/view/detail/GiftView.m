//
//  GiftView.m
//  live
//
//  Created by 黄成实 on 2018/7/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "GiftView.h"
#import "GiftViewCell.h"
#import "STUserDefaults.h"
#define GiftHeight (STWidth(255) + STHeight(44))

@interface GiftView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong, nonatomic)NSMutableArray *datas;
@property(strong ,nonatomic)UIView *contentView;
@property(strong, nonatomic)UILabel *totalLabel;

@end

@implementation GiftView

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
    
    _contentView = [[UIView alloc]init];
    _contentView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, GiftHeight);
    _contentView.userInteractionEnabled = YES;
    _contentView.backgroundColor = cblack;
    [self addSubview:_contentView];
    

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, GiftHeight - STHeight(44)) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollEnabled = NO;
    [_contentView addSubview:collectionView];
    
    [collectionView registerClass:[GiftViewCell class] forCellWithReuseIdentifier:[GiftViewCell identify]];
    
    
    int bb = [[STUserDefaults getKeyValue:UD_BB] intValue];
    NSString *totalStr = [NSString stringWithFormat:@"B币：%d",bb];
    _totalLabel = [[UILabel alloc]initWithFont:STFont(14) text:totalStr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    _totalLabel.userInteractionEnabled = YES;
    _totalLabel.frame = CGRectMake(0, GiftHeight - STHeight(44), ScreenWidth, STHeight(44));
    [_contentView addSubview:_totalLabel];
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
    return [_datas count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GiftViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GiftViewCell identify] forIndexPath:indexPath];
    [cell.contentView setBackgroundColor:[cblack colorWithAlphaComponent:0.65]];
    if(_datas && !IS_NS_COLLECTION_EMPTY(_datas)){
        GiftModel *model = [_datas objectAtIndex:indexPath.row];
        [cell setData:model];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView  layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CGFloat width = (ScreenWidth - STWidth(40))/3;
    return CGSizeMake(width, width);
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
    return UIEdgeInsetsMake(STWidth(10), STWidth(10), STWidth(10), STWidth(10));
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger position = indexPath.row;
    if(_delegate){
        [_delegate onSelectItem:[_datas objectAtIndex:position]];
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideGiftView:YES];
}




@end
