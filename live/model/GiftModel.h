//
//  GiftModel.h
//  live
//
//  Created by 黄成实 on 2018/7/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftModel : NSObject

@property(strong, nonatomic)NSString *giftName;
@property(strong, nonatomic)NSString *giftImageUrl;
@property(assign, nonatomic)int giftPrice;


+(GiftModel *)buildModel:(NSString *)giftName url:(NSString *)giftImageUrl price:(int)giftPrice;

@end
