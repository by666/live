//
//  STAlertSheet.h
//
//  Copyright (c) 2015 idreamsky. All rights reserved.
//


@class STAlertSheet;

typedef void (^IDSAlertSheetCallback)(NSInteger index);


//点击 Button 回调
@protocol IDSAlertSheetDelegate <NSObject>

@optional
- (void)alertSheetAction:(STAlertSheet *)sheet buttonIndex:(NSUInteger)index;

@end


@interface IDSAlertButton : UIButton

// 显示文本
@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) UIImageView *icon;

+ (IDSAlertButton *)buttonWithText:(NSString *)text;

- (id)initWithText:(NSString *)text;

@end


@interface STAlertSheet : UIView

@property (copy, nonatomic) IDSAlertSheetCallback alertCallback;

@property (weak, nonatomic) id<IDSAlertSheetDelegate> alertDelegate;


// 是否可以点击背景取消显示
@property (assign, nonatomic) BOOL outerSideCanCancel;

/**
 *  初始化,只有文本,没有 Button.
 */
- (instancetype)initWithTitle:(NSString *)title;

- (instancetype)initWithTitle:(NSString *)title titleIcon:(UIImage *)icon;

/**
 *  初始化.
 *
 *  @param title  显示的文本.
 *  @param titles 需要展示的 Button 上面的文本信息.
 */
- (instancetype)initWithTitle:(NSString *)title buttonTitles:(NSArray *)titles;

/**
 *  初始化.
 *
 *  @param title  显示文本.
 *  @param icon   文本icon.
 *  @param image  文本背景.
 *  @param titles 需要展示的 Button 上面的文本信息.
 */
- (instancetype)initWithTitle:(NSString *)title titleIcon:(UIImage *)icon buttonTitles:(NSArray *)titles;

/**
 *  设置 Button 的字体颜色
 *
 *  @param index 注意索引从0开始.
 *  @param color 需要显示的颜色.
 */
- (void)setSheetButtonTitleColor:(NSUInteger)index withColor:(UIColor *)color;

- (void)setSheetButtonIcon:(NSUInteger)index withImage:(UIImage *)image;

/**
 *  普通提示显示.
 */
- (void)show;

- (void)showSuccess;

- (void)showFailure;

- (void)showWithColor:(NSString *)colorHex;

- (void)showWithUIColor:(UIColor *)color;

/**
 *  取消显示.
 */
- (void)dismiss;

/**
 *  显示遮罩层.
 */
- (void)showDimMask;

@end
