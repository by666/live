//
//  DialogHelper.m
//  Radar
//
//  Created by mark.zhang on 6/30/15.
//  Copyright (c) 2015 com.brotherhood. All rights reserved.
//

#import "STToastUtil.h"
#import "STAlertSheet.h"

@implementation STToastUtil

+ (STAlertSheet *)showDialog:(NSString *)title withDelegate:(id<IDSAlertSheetDelegate>)delegate
{
    NSArray *buttons = [NSArray arrayWithObjects:@"确定", @"取消", nil];
    STAlertSheet *dialog = [[STAlertSheet alloc] initWithTitle:title buttonTitles:buttons];
    if (delegate) {
        dialog.alertDelegate = delegate;
    }
    
    [dialog setSheetButtonTitleColor:1 withColor:[UIColor redColor]];
    [dialog showDimMask];
    dialog.outerSideCanCancel = NO;
    [dialog show];
    
    return dialog;
}

+ (STAlertSheet *)showDialog:(NSString *)title withButtonsTitle:(NSArray *)array withDelegate:(id<IDSAlertSheetDelegate>)delegate
{
    NSArray *buttons = [NSArray arrayWithArray:array];
    STAlertSheet *dialog = [[STAlertSheet alloc] initWithTitle:title buttonTitles:buttons];
    if (delegate) {
        dialog.alertDelegate = delegate;
    }
    
    [dialog setSheetButtonTitleColor:1 withColor:[UIColor redColor]];
    [dialog showDimMask];
    dialog.outerSideCanCancel = NO;
    
    [dialog show];
    
    return dialog;
}

+ (void)showTips:(NSString *)tips
{
    UIImage *image = [UIImage imageNamed:@"ic_error_cross_normal"];
    STAlertSheet *dialog = [[STAlertSheet alloc] initWithTitle:tips titleIcon:image];
    [dialog showFailure];
}

+ (void)showFailureAlertSheet:(NSString *)title
{
    if ([title isEqualToString:@"成功"]) {
        return;
    }
    UIImage *image = [UIImage imageNamed:@"ic_error_cross_normal"];
    STAlertSheet *sheet = [[STAlertSheet alloc] initWithTitle: title titleIcon:image];
    [sheet showFailure];
}

+ (void)showSuccessTips:(NSString *)tips
{
    UIImage *image = [UIImage imageNamed:@"ic_event_correct_normal"];
    STAlertSheet *dialog = [[STAlertSheet alloc] initWithTitle:tips titleIcon:image];
    [dialog showSuccess];
}

+ (void)showSuccessTipsNoIcon:(NSString *)tips
{
    STAlertSheet *dialog = [[STAlertSheet alloc] initWithTitle:tips titleIcon:nil];
    [dialog showSuccess];
}

+ (void)showWarnTips:(NSString *)tips
{
    STAlertSheet *dialog = [[STAlertSheet alloc] initWithTitle:tips];
    [dialog showWithUIColor:cwarn];
}



@end
