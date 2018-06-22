//
//  IDSAlertSheet.m
//  Radar
//
//  Created by mark.zhang on 6/8/15.
//  Copyright (c) 2015 idreamsky. All rights reserved.
//

#import "STAlertSheet.h"
#import "STExtendedLabel.h"

#define TITLE_HEIGHT    49.0
#define BTN_HEIGHT      36.0
#define DISAPPEAR_TIME  5.0

@implementation IDSAlertButton

+ (IDSAlertButton *)buttonWithText:(NSString *)text
{
    return [[self alloc] initWithText:text];
}

- (id)initWithText:(NSString *)text
{
    if (self = [super init]) {
        CGRect frame = CGRectZero;
        frame.size = CGSizeMake(ScreenWidth, BTN_HEIGHT);
        self.frame = frame;
        
        self.backgroundColor = [UIColor clearColor];

        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:15.0];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = text;
        
         UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
         UIView *bgView = [[UIVisualEffectView alloc] initWithEffect:blur];
        
        
        // 背景不可以点击
        bgView.userInteractionEnabled = NO;
        
        bgView.frame = CGRectMake(0, 0, self.width, TITLE_HEIGHT);
        [self addSubview:bgView];
        
        [self addSubview:_label];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    if (nil != _icon) {
        [_icon removeFromSuperview];
    }
    
    _icon = [[UIImageView alloc] init];
    _icon.image = image;
    _icon.frame = CGRectMake(self.label.width/2 - self.label.contentSize.width/2 - _icon.image.size.width - 1,
                             (self.height-image.size.height)/2,
                             _icon.image.size.width,
                             _icon.image.size.height);
    
    [self addSubview:_icon];
}

@end



@implementation STAlertSheet
{
    // Button 索引
    NSUInteger mIndex;
    
    CGFloat mStepY;
    
    UIView *mBgView;
    
    UIView *mTitleBgView;
    
    STExtendedLabel *mTitle;
    
    BOOL enableTitleTouch;
}

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title buttonTitles:nil];
}

- (instancetype)initWithTitle:(NSString *)title titleIcon:(UIImage *)icon
{
    return [self initWithTitle:title titleIcon:icon buttonTitles:nil];
}

- (instancetype)initWithTitle:(NSString *)title buttonTitles:(NSArray *)titles
{
    return [self initWithTitle:title titleIcon:nil buttonTitles:titles];
}

- (instancetype)initWithTitle:(NSString *)title titleIcon:(UIImage *)icon buttonTitles:(NSArray *)titles
{
    if (self = [super init]) {
        self.outerSideCanCancel = YES;
        
        // 主背景
        self.frame = CGRectMake(0.0, 0.0, ScreenWidth, ScreenHeight);
        // 默认不需要背景蒙版色
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0];
        
        // 视图层
        mBgView = [[UIView alloc] init];
        mBgView.backgroundColor = [UIColor whiteColor];
        mBgView.alpha = 1.0f;
        mBgView.userInteractionEnabled = YES;
        CGRect frame = mBgView.frame;
        frame.size = CGSizeMake(ScreenWidth, 380);
        frame.origin = CGPointMake(0, self.height);
        mBgView.frame = frame;
        
        // title
        if (!IS_NS_STRING_EMPTY(title)) {
            // 可以点击 title 取消视图显示
            enableTitleTouch = YES;
            
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            mTitleBgView = [[UIVisualEffectView alloc] initWithEffect:blur];
           
            
            mTitle = [[STExtendedLabel alloc] initWithInsets:UIEdgeInsetsMake(5, 0, 5, 0)];
            mTitle.textColor = [UIColor blackColor];
            [mTitle setTextAlignment:NSTextAlignmentCenter];
            mTitle.text = title;
            mTitle.font = [UIFont systemFontOfSize:14.0];
            mTitle.lineBreakMode = NSLineBreakByWordWrapping;
            mTitle.numberOfLines = 0;
            frame = mTitle.frame;
            frame.size.width = self.width;
            frame.size.height = mTitle.contentSize.height;
            if (mTitle.contentSize.height < TITLE_HEIGHT) {
                frame.size.height = TITLE_HEIGHT;
            }
            
            if (nil != icon) {
                frame.origin.x = (self.width - frame.size.width)/2 + 6;
            }
            
            mTitleBgView.tintColor = [UIColor clearColor];
            mTitleBgView.frame = CGRectMake(0, 0, self.width + 20, frame.size.height);
            [mBgView addSubview:mTitleBgView];
            
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(onClickTitleCallback:)];
            mTitleBgView.userInteractionEnabled = YES;
            [mTitleBgView addGestureRecognizer:gesture];
            
            if (nil != icon) {
                UIImageView *titleIcon = [[UIImageView alloc] init];
                titleIcon.image = icon;
                CGFloat iw = icon.size.width;
                CGFloat ih = icon.size.height;
                titleIcon.frame = CGRectMake((self.width-mTitle.contentSize.width)/2 - 14, (frame.size.height-ih)/2, iw, ih);
                [mBgView addSubview:titleIcon];
            }

            mTitle.frame = frame;
            [mBgView addSubview:mTitle];
            mStepY += mTitle.height;
        }
        
        // button
        if (nil != titles && [titles count] > 0) {
            // 提示框的话, 默认使用蒙版
            [self showDimMask];
            // title 后面添加分割线
            UIView *endLine = [[UIView alloc] initWithFrame:CGRectMake(0, mStepY, ScreenWidth, 0.5)];
            endLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
            [mBgView addSubview:endLine];
            
            for (int indexCounter = 0; indexCounter < titles.count; indexCounter++) {
                IDSAlertButton *alertButton = [IDSAlertButton buttonWithText:[titles objectAtIndex:indexCounter]];
                frame = alertButton.frame;
                frame.origin.x = (self.width - frame.size.width)/2;
                frame.origin.y = mStepY + 5;
                alertButton.frame = frame;
                alertButton.tag = indexCounter + 1;
                [alertButton addTarget:self action:@selector(onClickSheetCallback:) forControlEvents:UIControlEventTouchUpInside];
                [mBgView addSubview:alertButton];
                mStepY += alertButton.height + 10;
                
                // button添加分割线
                if (indexCounter <= titles.count - 1) {
                    UIView *btnLine = [[UIView alloc] initWithFrame:CGRectMake(0, mStepY, ScreenWidth, 0.5)];
                    btnLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
                    [mBgView addSubview:btnLine];
                }
            }
            
            frame = mBgView.frame;
            frame.size.width = self.width;
            frame.size.height = mStepY;
            mBgView.frame = frame;
            
            // 此时 titleBgView 不可以点击
            enableTitleTouch = NO;
        }
        
        [self addSubview:mBgView];
        [self startAnimate];
    }
    
    return self;
}

- (void)show:(CGFloat)time
{
    // 隐藏键盘
    NSArray *subviews = [[[UIApplication sharedApplication] keyWindow ] subviews];
    if (nil != subviews && subviews.count > 0) {
        [[subviews lastObject] endEditing:YES];
    }
    
    // 当前已有显示的就 remove
    //[self removeSelf];
    
    // 添加并显示
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    // 自动消失
    [self performSelector:@selector(removeSelf) withObject:nil afterDelay:time];
}

- (void)show
{
    // 隐藏键盘
    NSArray *subviews = [[[UIApplication sharedApplication] keyWindow] subviews];
    if (nil != subviews && subviews.count > 0) {
        [[subviews lastObject] endEditing:YES];
    }
    
    // 添加并显示
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)showSuccess
{
    [self showWithColor:@"#67b801"];
}

- (void)showFailure
{
    [self showWithUIColor:cwarn];
}

- (void)showWithColor:(NSString *)colorHex
{
    mTitle.textColor = [UIColor whiteColor];
    mTitleBgView.backgroundColor = [STColorUtil colorWithHexString:colorHex alpha:1.0f];
    [self show:DISAPPEAR_TIME];
}

- (void)showWithUIColor:(UIColor *)color
{
    mTitle.textColor = [UIColor whiteColor];
    mTitleBgView.backgroundColor = color;
    [self show:DISAPPEAR_TIME];
}

- (void)onClickSheetCallback:(id)sender
{
    IDSAlertButton *button = (IDSAlertButton *)sender;
    mIndex = (int)button.tag;
    [self stopAnimate];
}

- (void)onClickTitleCallback:(id)sender
{
    if (enableTitleTouch) {
        [self removeSelf];
    }
}

- (void)removeSelf
{
    [self removeFromSuperview];
}

- (void)setSheetButtonTitleColor:(NSUInteger)index withColor:(UIColor *)color
{
    id view = [mBgView viewWithTag:(index)];
        
    if ([view isKindOfClass:[IDSAlertButton class]]) {
        IDSAlertButton *btn = (IDSAlertButton *)view;
        btn.label.textColor = [UIColor redColor];
    }
}

- (void)setSheetButtonIcon:(NSUInteger)index withImage:(UIImage *)image
{
    id view = [mBgView viewWithTag:(index)];
    
    if ([view isKindOfClass:[IDSAlertButton class]]) {
        IDSAlertButton *btn = (IDSAlertButton *)view;
        [btn setImage:image];
    }
}

- (void)dismiss
{
    [self removeSelf];
}

- (void)showDimMask
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.55f];
}

#pragma mark TouchEvent.

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.outerSideCanCancel) {
        __weak STAlertSheet *weakSelf = self;
        if (weakSelf.alertCallback) {
            weakSelf.alertCallback(-1);
        }
        
        [self removeSelf];
    }
}

#pragma mark Animation.

- (void)startAnimate
{
    [UIView animateWithDuration:0.23 animations:^{
        CGRect frame = mBgView.frame;
        frame.origin.y -= mStepY;
        mBgView.frame = frame;
    }];
}

- (void)stopAnimate
{
    __weak STAlertSheet *weakSelf = self;
    [UIView animateWithDuration:0.23 animations:^{
        CGRect frame = mBgView.frame;
        frame.origin.y += mStepY;
        mBgView.frame = frame;
    } completion:^(BOOL complete) {
        if (weakSelf.alertDelegate) {
            [weakSelf.alertDelegate alertSheetAction:weakSelf buttonIndex:mIndex];
        }
        
        if (weakSelf.alertCallback) {
            weakSelf.alertCallback(mIndex);
        }
        
        [weakSelf removeSelf];
    }];
}

@end
