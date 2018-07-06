//
//  ChatViewCell.h
//  live
//
//  Created by 黄成实 on 2018/7/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
@interface ChatViewCell : UITableViewCell

-(void)updateView:(ChatModel *)chatModel;

+(NSString *)identify;

@end
