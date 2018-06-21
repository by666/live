//
//  TouchScrollView.h
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TouchScrollViewDelegate

@optional
-(void)uploadMore;
-(void)refreshNew;

@end

@interface TouchScrollView : UIScrollView

@property (weak, nonatomic) id touchScollViewDelegate;

-(instancetype)initWithParentView : (UIView *)view delegate:(id<TouchScrollViewDelegate>)delegate;

//支持下拉刷新
-(void)enableHeader;

//支持上拉加载
-(void)enableFooter;

//结束上拉加载
-(void)endUploadMore;

//结束下拉刷新
-(void)endRefreshNew;

@end
