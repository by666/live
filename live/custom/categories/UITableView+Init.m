//
//  UITableView+Init.m
//  framework
//
//  Created by 黄成实 on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UITableView+Init.h"

@implementation UITableView(Init)


-(void)useDefaultProperty{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight=0;
        self.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    
}

@end
