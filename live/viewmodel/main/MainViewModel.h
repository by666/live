//
//  MainViewModel.h
//  live
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainModel.h"

@protocol MainViewDelegate<BaseRequestDelegate>

-(void)onGoDetailPage:(MainModel *)mainModel;

@end

@interface MainViewModel : NSObject

@property(weak, nonatomic)id<MainViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;

-(instancetype)init;
-(void)requestData;
-(void)goDetailPage:(MainModel *)mainModel;

@end
