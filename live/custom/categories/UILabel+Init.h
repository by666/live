//
//  UILabel+Init.h
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(Init)

-(instancetype)initWithFont:(CGFloat)fontSize text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor multiLine:(Boolean)multiLine;

@end
