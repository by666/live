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

-(void)onUserOffline;
-(void)onShowNavigationBar;
-(void)onReportResult;
-(void)onHideGiftView:(Boolean)hidden;

@end

@interface DetailViewModel : NSObject

@property(weak, nonatomic)id<DetailViewDelegate> delegate;
@property(strong, nonatomic)DetailModel *detailModel;
@property(strong, nonatomic)NSMutableArray *chatDatas;
@property(strong, nonatomic)NSMutableArray *giftDatas;

-(instancetype)initWithMainModel:(MainModel *)mainModel;
//请求数据
-(void)requestData;
//主播离线
-(void)useroffline;
//显示导航栏
-(void)showNavigationBar;
//举报
-(void)report;
//显示/隐藏giftView
-(void)hideGiftView:(Boolean)hidden;

@end
