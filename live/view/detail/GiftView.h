//
//  GiftView.h
//  live
//
//  Created by 黄成实 on 2018/7/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftModel.h"

@protocol GiftViewDelegate

-(void)onSelectItem:(GiftModel *)giftModel;

@end

@interface GiftView : UIView

@property(weak, nonatomic)id<GiftViewDelegate> delegate;

-(instancetype)initWithDatas:(NSMutableArray *)datas;
-(void)hideGiftView:(Boolean)hidden;

@end
