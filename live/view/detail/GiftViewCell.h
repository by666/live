//
//  GiftViewCell.h
//  live
//
//  Created by 黄成实 on 2018/7/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftModel.h"

@interface GiftViewCell  : UICollectionViewCell

-(void)setData:(GiftModel *)model;
+(NSString *)identify;


@end
