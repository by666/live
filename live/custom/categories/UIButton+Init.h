//
//  UIButton+Init.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(Init)

@property (copy,nonatomic) NSString *tag2;

-(instancetype)initWithFont:(CGFloat)fontSize text:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor corner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
