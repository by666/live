//
//  HomeViewModel.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol HomeViewDelegate<BaseRequestDelegate>
    
@end


@interface HomeViewModel : NSObject
    
@property(weak, nonatomic)id<HomeViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
-(instancetype)init;

@end


