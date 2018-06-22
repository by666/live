//
//  STExtendedLabel.h
//  Radar
//
//  Copyright (c) 2015 idreamsky. All rights reserved.
//
//  可以自定义 padding.
//


@interface STExtendedLabel : UILabel

@property (nonatomic) UIEdgeInsets insets;

- (instancetype)initWithFrame:(CGRect)frame insets:(UIEdgeInsets)insets;

- (instancetype)initWithInsets:(UIEdgeInsets)insets;

- (void)setOnClickListener:(id)target selector:(SEL)callback;

@end
