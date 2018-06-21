//
//  STAlertUtil.m
//  framework
//
//  Created by 黄成实 on 2018/5/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STAlertUtil.h"

@implementation STAlertUtil

+(void)showAlertController:(NSString *)title content:(NSString *)content controller:(UIViewController *)controller{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(void)showAlertController:(NSString *)title content:(NSString *)content controller:(UIViewController *)controller confirm:(void (^)(void))click{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
        
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        click();
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(void)showAlertController:(NSString *)title content:(NSString *)content controller:(UIViewController *)controller confirm:(void (^)(void))confirmClick cancel:(void(^)(void))cancelClick{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancelClick();
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        confirmClick();
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}


+(void)showSheetController:(NSString *)title content:(NSString *)content controller:(UIViewController *)controller sheetModels:(NSMutableArray *)sheetModels{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    
    if(!IS_NS_COLLECTION_EMPTY(sheetModels)){
        for(STSheetModel *sheetModel in sheetModels){
            UIAlertAction *tempAction = [UIAlertAction actionWithTitle:sheetModel.title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                sheetModel.click();
            }];
            [alertController addAction:tempAction];
        }
    }
    [controller presentViewController:alertController animated:YES completion:nil];
}

@end
