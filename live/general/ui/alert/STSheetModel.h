//
//  STSheetModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STSheetModel : NSObject

@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)void(^click)(void);

@end
