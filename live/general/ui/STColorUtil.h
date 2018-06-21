//
//  STColorUtil.h
//
//  Created by mark.zhang on 6/5/15.
//  Copyright (c) 2015 idreamsky. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_VOID_COLOR [UIColor whiteColor]

typedef NS_ENUM(NSInteger,ColorDirector){
    Left = 0,
    Top
};

@interface STColorUtil : NSObject

#pragma mark 色彩转换UIColor,带alpha值
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

#pragma mark 色彩转换UIColor
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

#pragma mark 设置颜色渐变
+ (void)setGradientColor : (UIView *)view startColor: (UIColor *)startColor endColor : (UIColor *)endColor director : (ColorDirector)director;

#pragma mark 模糊图层
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end
