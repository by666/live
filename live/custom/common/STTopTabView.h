//
//  STTopTabView.h
//  live
//
//  Created by by.huang on 2019/2/14.
//  Copyright © 2019 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol STTopTabViewDelegate

-(void)onTopTabSelected:(NSInteger)index;

@end

@interface STTopTabView : UIView

@property(weak, nonatomic)id<STTopTabViewDelegate> delegate;

-(instancetype)initWithTitles:(NSArray *)titles;


@end

NS_ASSUME_NONNULL_END
