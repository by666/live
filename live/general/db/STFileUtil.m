//
//  STFileUtil.m
//  framework
//
//  Created by 黄成实 on 2018/4/26.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STFileUtil.h"

@implementation STFileUtil

+(NSString *)saveImageFile:(NSString *)filePath image:(UIImage *)image{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageFilePath = [path stringByAppendingPathComponent:filePath];
    BOOL statu = [UIImageJPEGRepresentation(image, 100) writeToFile:imageFilePath  atomically:YES];
    if(statu){
        [STLog print:@"图片保存成功"];
        return imageFilePath;
    }else{
        [STLog print:@"图片保存失败"];
    }
    return nil;
}


+(NSString *)getJsonStr:(NSString *)filename{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSString *jsonStr  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}
@end
