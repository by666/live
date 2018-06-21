//
//  STSwitchView.h
//  framework
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STSwitchViewDelegate

-(void)onSwitchStatuChange:(Boolean)on;

@end

@interface STSwitchView : UIView

@property(weak, nonatomic)id<STSwitchViewDelegate> delegate;
@property(assign, nonatomic)Boolean on;

-(void)setOn:(Boolean)on;

@end
