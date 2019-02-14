//
//  STPlayerView.h
//  live
//
//  Created by by.huang on 2019/2/14.
//  Copyright © 2019 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STPlayerView : UIView

-(instancetype)initWithUrl:(NSString *)url;
-(void)startPlay:(NSInteger)index;
-(void)stopPlay;

@end

NS_ASSUME_NONNULL_END
