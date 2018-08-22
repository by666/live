//
//  UIButton+Init.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UIButton+Init.h"
#import <objc/runtime.h>

static char *tag2Value = "tag2Value";

@implementation UIButton(Init)


-(instancetype)initWithFont:(CGFloat)fontSize text:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor corner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    if(self == [super init]){
        [self setTitle:text forState:UIControlStateNormal];
        if(textColor != nil){
            [self setTitleColor:textColor forState:UIControlStateNormal];
        }
        if(backgroundColor != nil){
            self.backgroundColor = backgroundColor;
        }
        if(borderColor != nil){
            self.layer.borderColor = [borderColor CGColor];
        }
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = corner;
        self.layer.borderWidth = borderWidth;
        
    }
    return self;
}


-(void)setTag2:(NSString *)tag2{
    objc_setAssociatedObject(self, &tag2Value, tag2, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)tag2{
    return objc_getAssociatedObject(self, &tag2Value);
}


- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}


+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
