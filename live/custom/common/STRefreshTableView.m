//
//  STRefreshTableView.m
//  framework
//
//  Created by 黄成实 on 2018/4/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STRefreshTableView.h"

@implementation STRefreshTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    return cell;
}

@end
