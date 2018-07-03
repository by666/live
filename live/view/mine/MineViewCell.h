//
//  MineViewCell.h
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleContentModel.h"
@interface MineViewCell : UITableViewCell


-(void)updateData:(TitleContentModel *)model showLine:(Boolean)showLine;

+(NSString *)identify;

@end
