//
//  DetailViewModel.h
//  live
//
//  Created by by.huang on 2018/6/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainModel.h"
#import "DetailModel.h"

@protocol DetailViewDelegate<BaseRequestDelegate>


@end

@interface DetailViewModel : NSObject

@property(weak, nonatomic)id<DetailViewDelegate> delegate;
@property(strong, nonatomic)DetailModel *detailModel;

-(instancetype)initWithMainModel:(MainModel *)mainModel;
-(void)requestData;

@end
