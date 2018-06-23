//
//  DetailPage.h
//  live
//
//  Created by by.huang on 2018/6/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BaseViewController.h"
#import "MainModel.h"
@interface DetailPage : BaseViewController

+(void)show:(MainModel *)mainModel controller:(BaseViewController *)controller;

@end
