//
//  UILabel+Init.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UILabel+Init.h"

@implementation UILabel(Init)

-(instancetype)initWithFont:(CGFloat)fontSize text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor multiLine:(Boolean)multiLine{
    if(self == [super init]){
        self.text = text;
        self.textAlignment = textAlignment;
        if(multiLine){
            self.numberOfLines = 0;
            self.lineBreakMode = NSLineBreakByCharWrapping;
        }
        if(textColor != nil){
            self.textColor = textColor;
        }
        if(backgroundColor != nil){
            self.backgroundColor = backgroundColor;
        }
        self.font = [UIFont systemFontOfSize:fontSize];
    }
    return self;
}


@end
