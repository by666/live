//
//  STAlertUtil.h
//  framework
//
//  Created by 黄成实 on 2018/5/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STSheetModel.h"


@interface STAlertUtil : NSObject

//对话框只有取消按钮
+(void)showAlertController:(NSString *)title content:(NSString *)content controller:(UIViewController *)controller;

//对话框有取消和确认按钮，确认按钮有回调
+(void)showAlertController:(NSString *)title content:(NSString *)content controller:(UIViewController *)controller confirm:(void (^)(void))click;

//对话框有取消和确认按钮,都有回调
+(void)showAlertController:(NSString *)title content:(NSString *)content controller:(UIViewController *)controller confirm:(void (^)(void))confirmClick cancel:(void(^)(void))cancelClick;

//sheet
+(void)showSheetController:(NSString *)title content:(NSString *)content controller:(UIViewController *)controller sheetModels:(NSMutableArray *)sheetModels;

@end

