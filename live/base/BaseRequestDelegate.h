//
//  BaseRequestDelegate.h
//  framework
//
//  Created by 黄成实 on 2018/6/12.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RespondModel.h"
@protocol BaseRequestDelegate

-(void)onRequestBegin;
-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data;
-(void)onRequestFail:(NSString *)msg;

@end
