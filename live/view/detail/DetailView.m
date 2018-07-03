//
//  DetailView.m
//  live
//
//  Created by by.huang on 2018/6/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DetailView.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "STTabBarView.h"
#import "ChatView.h"
#import "GiftView.h"

@interface DetailView()<UIScrollViewDelegate>

@property(strong, nonatomic)STTabBarView *tabBarView;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)ChatView *chatView;
@property(strong, nonatomic)GiftView *giftView;

@property(strong, nonatomic)DetailViewModel *mViewModel;
@property(atomic, retain) id<IJKMediaPlayback> player;
@property(strong, nonatomic)UIButton *expandBtn;

@end

@implementation DetailView{
    Boolean isFullScreen;
}

-(instancetype)initWithViewModel:(DetailViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [IJKFFMoviePlayerController setLogReport:YES];
        [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_DEBUG];
        [_mViewModel requestData];
        [self initView];
    }
    return self;
}


-(void)initView{
    
    UILabel *waitLabel = [[UILabel alloc]initWithFont:STFont(18) text:@"主播正在快马加鞭赶来..." textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:c16 multiLine:NO];
    waitLabel.frame = CGRectMake(0, 0, ScreenWidth, VideoHeight);
    [self addSubview:waitLabel];
    
    NSArray *titles = @[MSG_DETAIL_CHAT,MSG_DETAIL_GIFT];
    _tabBarView = [[STTabBarView alloc]initWithTitles:titles];
    [_tabBarView setData:c12 SelectColor:c19 Font:[UIFont systemFontOfSize:STFont(16)]];
    [_tabBarView setLineHeight:1];
    [self addSubview:_tabBarView];
    
    WS(weakSelf)
    [_tabBarView getViewIndex:^(NSString *title, NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(index * ScreenWidth, 0);
        }];
    }];
    
    [_tabBarView setIndexBlock:^(NSString *title, NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(index * ScreenWidth, 0);
        }];
    }];
    
    [_tabBarView setViewIndex:0];
    
    CGFloat scrollHeight = ScreenHeight - STHeight(44) - VideoHeight;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, VideoHeight + STHeight(44) , ScreenWidth, scrollHeight)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake([titles count]*ScreenWidth, 0);
    [self addSubview:_scrollView];
    
    _chatView = [[ChatView alloc]initWithViewModel:_mViewModel];
    _chatView.frame = CGRectMake(0, 0, ScreenWidth, scrollHeight);
    
    _giftView = [[GiftView alloc]initWithViewModel:_mViewModel];
    _giftView.frame = CGRectMake(ScreenWidth,0, ScreenWidth, scrollHeight);
    
    [_scrollView addSubview:_chatView];
    [_scrollView addSubview:_giftView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    [_tabBarView setViewIndex:index];
}


-(void)updateView{
    
    [IJKFFMoviePlayerController checkIfFFmpegVersionMatch:YES];
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_mViewModel.detailModel.live_url] withOptions:options];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = CGRectMake(0, 0, ScreenWidth, VideoHeight);
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.shouldAutoplay = YES;

    self.autoresizesSubviews = YES;
    [self addSubview:self.player.view];
    [self installMovieNotificationObservers];
    [self.player prepareToPlay];
    [self.player play];
    
    if(_mViewModel){
        [_mViewModel showNavigationBar];
    }
    
    
    _expandBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(40), VideoHeight - STHeight(40), STWidth(30), STWidth(30))];
    [_expandBtn setImage:[UIImage imageNamed:@"ic_expand"] forState:UIControlStateNormal];
    [_expandBtn addTarget:self action:@selector(showFullScreen) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_expandBtn];
    
//    WS(weakSelf)
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakSelf showFullScreen];
//    });

}


-(void)showFullScreen{
    WS(weakSelf)
    if(isFullScreen){
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.player.view.transform = CGAffineTransformMakeRotation(0);
            weakSelf.player.view.frame = CGRectMake(0, 0, ScreenWidth, VideoHeight);
            weakSelf.expandBtn.frame = CGRectMake(ScreenWidth - STWidth(40), VideoHeight - STHeight(40), STWidth(30), STWidth(30));
        }];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.player.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            weakSelf.player.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            [STLog print:[NSString stringWithFormat:@"%.f",ScreenWidth]];
            [STLog print:[NSString stringWithFormat:@"%.f",ScreenHeight]];

            weakSelf.expandBtn.frame = CGRectMake(STWidth(40), ScreenHeight - STHeight(40), STWidth(30), STWidth(30));
        }];
    }
    isFullScreen = ! isFullScreen;
 
}


-(void)installMovieNotificationObservers
{
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

- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,
    //    MPMovieLoadStatePlayable       = 1 << 0,
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,
    //    MPMovieFinishReasonPlaybackError,
    //    MPMovieFinishReasonUserExited
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

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
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
            if(_mViewModel){
                [_mViewModel useroffline];
            }
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
//    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started

-(void)removeView{
    [self.player shutdown];
    [self removeMovieNotificationObservers];
}

/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}
@end
