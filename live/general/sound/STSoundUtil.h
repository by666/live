//
//  SoundUtil.h
//
//
//  Created by by.huang on 16/9/18.
//  Copyright © 2016年 com.smh.pcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
@interface STSoundUtil : NSObject

+(SystemSoundID)creatSoundIDWithSoundName:(NSString *)soundName;
+(void)playSoundWithSoundID:(SystemSoundID)soundID;
+(void)stopSoundWithSoundID:(SystemSoundID)soundID;

@end
