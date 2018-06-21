//
//  STLayerView.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STLayerView.h"

@implementation STLayerView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat r = STWidth(280);
    
    //中间镂空的矩形框
    CGRect myRect =CGRectMake((width - r)/2,height / 5,r, r);
    
    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    //镂空
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:myRect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [cblack colorWithAlphaComponent:0.8f].CGColor;
    fillLayer.opacity = 0.9;
    [self.layer addSublayer:fillLayer];
    
}

@end
