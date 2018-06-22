//
//  STExtendedLabel.m
//
//  Copyright (c) 2015 idreamsky. All rights reserved.
//

#import "STExtendedLabel.h"

@implementation STExtendedLabel

- (instancetype)initWithFrame:(CGRect)frame insets:(UIEdgeInsets)insets
{
    if (self = [super initWithFrame:frame]) {
        self.insets = insets;
    }
    
    return self;
}

- (instancetype)initWithInsets:(UIEdgeInsets)insets
{
    if (self = [super init]) {
        self.insets = insets;
    }
    
    return self;
}

- (void)drawTextInRect:(CGRect)rect
{
    CGRect curRect = UIEdgeInsetsInsetRect(rect, self.insets);
    [super drawTextInRect:curRect];
}

- (void)setOnClickListener:(id)target selector:(SEL)callback
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:callback];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:gesture];
}

@end

