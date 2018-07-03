//
//  MineView.h
//  live
//
//  Created by by.huang on 2018/7/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineViewModel.h"
@interface MineView : UIView

-(instancetype)initWithViewModel:(MineViewModel *)viewModel;
-(void)updateView;
@end
