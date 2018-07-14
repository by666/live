//
//  DetailView.h
//  live
//
//  Created by by.huang on 2018/6/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewModel.h"
@interface DetailView : UIView

-(instancetype)initWithViewModel:(DetailViewModel *)viewModel;
-(void)updateView;
-(void)removeView;
-(void)updateChatView;

@end
