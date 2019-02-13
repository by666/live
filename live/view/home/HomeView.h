//
//  HomeView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewModel.h"


@interface HomeView : UIView
    
-(instancetype)initWithViewModel:(HomeViewModel *)viewModel;
-(void)updateView;
    
    @end

