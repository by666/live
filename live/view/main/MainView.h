//
//  MainView.h
//  live
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewModel.h"

@interface MainView : UIView

-(instancetype)initWithViewModel:(MainViewModel *)viewModel;
-(void)updateView;

@end
