//
//  UIView+Frame.h
//  framework
//
//  Created by by.huang on 6/5/15.
//  Copyright (c) 2015 idreamsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property(assign, nonatomic) CGFloat x;

@property(assign, nonatomic) CGFloat y;

@property(assign, nonatomic) CGFloat width;

@property(assign, nonatomic) CGFloat height;

@property(assign, nonatomic) CGSize  size;

@property(assign, nonatomic) CGFloat centerX;

@property(assign, nonatomic) CGFloat centerY;

@property (assign, nonatomic, readonly) CGFloat right;

@property (assign, nonatomic, readonly) CGFloat bottom;

- (CGFloat)maxXOfFrame;

@end
