//
//  STPlayerView.m
//  live
//
//  Created by by.huang on 2019/2/14.
//  Copyright © 2019 黄成实. All rights reserved.
//

#import "STPlayerView.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface STPlayerView ()

@property(atomic, retain)id<IJKMediaPlayback> player;
@property(copy, nonatomic)NSString *mUrl;

@end

@implementation STPlayerView

-(instancetype)initWithUrl:(NSString *)url{
    if(self == [super init]){
        _mUrl = url;
        [self initView];
    }
    return self;
}

-(void)initView{
    [IJKFFMoviePlayerController setLogReport:YES];
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_DEBUG];
    
}

-(void)startPlay:(NSInteger)index{
    [IJKFFMoviePlayerController checkIfFFmpegVersionMatch:YES];
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];

    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_mUrl] withOptions:options];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = CGRectMake(0, ScreenHeight * index, ScreenWidth, ScreenHeight);
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.shouldAutoplay = YES;

    self.autoresizesSubviews = YES;
    [self addSubview:self.player.view];
    [self installMovieNotificationObservers];
    [self.player prepareToPlay];
    [self.player play];
}

-(void)stopPlay{
    [self removeView];
    [self removeMovieNotificationObservers];
}


-(void)installMovieNotificationObservers{
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadStateDidChange:)
                                                     name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                   object:_player];
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                   object:_player];
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                     name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                   object:_player];
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackStateDidChange:)
                                                     name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                   object:_player];
}


- (void)loadStateDidChange:(NSNotification*)notification{
    IJKMPMovieLoadState loadState = _player.loadState;

    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification{
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];

    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;

        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;

        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;

        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification{
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
//            if(_mViewModel){
//                [_mViewModel useroffline];
//            }
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

-(void)removeView{
    [self.player shutdown];
    [self removeMovieNotificationObservers];
}

-(void)removeMovieNotificationObservers{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}

@end
