//
//  GiftModel.m
//  live
//
//  Created by 黄成实 on 2018/7/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "GiftModel.h"

@implementation GiftModel

+(GiftModel *)buildModel:(NSString *)giftName url:(NSString *)giftImageUrl price:(int)giftPrice{
    GiftModel *model = [[GiftModel alloc]init];
    model.giftName = giftName;
    model.giftPrice = giftPrice;
    model.giftImageUrl = giftImageUrl;
    return model;
}

@end
