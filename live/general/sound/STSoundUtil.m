//
//  STSoundUtil.m
//
//
//  Created by by.huang on 16/9/18.
//  Copyright © 2016年 com.smh.pcn. All rights reserved.
//

#import "STSoundUtil.h"

@implementation STSoundUtil
/**生成音效ID*/
+(SystemSoundID)creatSoundIDWithSoundName:(NSString *)soundName{
    NSString *audioFile = [[NSBundle mainBundle]pathForResource:soundName ofType:nil];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID=0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    return soundID;
}
/**播放音效*/
+(void)playSoundWithSoundID:(SystemSoundID)soundID{
    //2.播放音频
    AudioServicesPlaySystemSound(soundID);//播放音效
    //    AudioServicesPlayAlertSound(self.soundID);//播放音效并震动
}
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
    //停止播放音效
    AudioServicesDisposeSystemSoundID(soundID);
}
/**停止播放音效*/
+(void)stopSoundWithSoundID:(SystemSoundID)soundID{
    //停止播放音效
    AudioServicesDisposeSystemSoundID(soundID);
}

@end
