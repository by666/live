//
//  UserModel.h
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>




//token
@property (copy, nonatomic)NSString *token;
//用户id
@property (copy, nonatomic)NSString *uid;
//手机号
@property (copy, nonatomic)NSString *phone;
//昵称
@property (copy, nonatomic)NSString *nick;
//性别
@property (copy, nonatomic)NSString *gender;
//剩余钻石
@property (assign, nonatomic)long diamond;
//账号剩余可免费直播次数
@property (assign, nonatomic)int view_count;
//是否开通直播间聊天功能
@property (assign, nonatomic)NSString *chat_state;
//创建时间
@property (assign, nonatomic)NSString *create_ts;
//过期时间
@property (assign, nonatomic)NSString *expired_ts;

////会员剩余时间
//@property (assign, nonatomic)int vipDays;
////公告栏展示图
//@property (copy, nonatomic)NSString *imageUrl;
////公告栏点击下载app地址
//@property (copy, nonatomic)NSString *downUrl;
////优惠活动标题
//@property (copy, nonatomic)NSString *activity_title;
////优惠活动内容
//@property (copy, nonatomic)NSString *activity_content;
////优惠活动原价
//@property (assign, nonatomic)double activity_origin_price;
////优惠活动现价
//@property (assign, nonatomic)double activity_price;



@end
