//
//  UITextField+Init.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField(Init)

@property (nonatomic,copy) NSString *hasValue;
@property (nonatomic,copy) NSString *maxLength;


-(instancetype)initWithFont:(CGFloat)fontSize textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor corner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor padding:(CGFloat)padding;


-(void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color fontSize:(CGFloat)fontSize;


@end
