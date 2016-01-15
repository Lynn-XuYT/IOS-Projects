//
//  YTMovieViewController.m
//  0115媒体播放器
//
//  Created by Lynn on 16/1/15.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "YTMovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "YTPlayerView.h"
@interface YTMovieViewController ()


@property(nonatomic, strong) AVPlayerViewController *avPlayer;

@property(nonatomic, strong) MPMoviePlayerController *moviePlayer;

@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) AVPlayerItem *playerItem;
@property(nonatomic, strong) YTPlayerView *playerView;

@end
@implementation YTMovieViewController


#pragma mark - 弃用的方法

- (MPMoviePlayerController *)moviePlayer
{
    if (!_moviePlayer) {
        // 负责控制媒体播放的控制器
        
        _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:self.movieURL];
        
        _moviePlayer.view.frame = self.view.bounds;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}


- (void)addNotificaion
{
    // 添加播放状态的监听
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(stateChanged) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    
    // 播放完成
    [nc addObserver:self selector:@selector(finished) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // 全屏
    [nc addObserver:self selector:@selector(finished) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
    // 截屏
    [nc addObserver:self selector:@selector(captureFinished:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    [self captureImageAtTime:0.5];
}

- (void)captureImageAtTime:(float)time
{
    [self.moviePlayer requestThumbnailImagesAtTimes:@[@(time)] timeOption:MPMovieTimeOptionNearestKeyFrame];
}
- (void)captureFinished:(NSNotification *)notification
{
    NSLog(@"captureFinished:%@",notification);
    if ([self.delegate respondsToSelector:@selector(moviePlayerDidCapturedWithImage:)]) {
        [self.delegate moviePlayerDidCapturedWithImage:notification.userInfo[MPMoviePlayerThumbnailImageKey]];
    }
}
- (void)finished
{
    // 删除通知监听AVPlayerViewController
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    // 返回上级窗体
    // 谁申请，谁释放
//    [self dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(moviePlayerDidFinished:)]) {
        [self.delegate moviePlayerDidFinished:self];
    }
    NSLog(@"播放完成");
}
/**
 *      MPMoviePlaybackStateStopped,
 *      MPMoviePlaybackStatePlaying,
 *      MPMoviePlaybackStatePaused,
 *      MPMoviePlaybackStateInterrupted,
 *      MPMoviePlaybackStateSeekingForward,
 *      MPMoviePlaybackStateSeekingBackward
 */
- (void)stateChanged
{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStateStopped:
            NSLog(@"MPMoviePlaybackStateStopped");
            break;
        case MPMoviePlaybackStatePlaying:
            NSLog(@"MPMoviePlaybackStatePlaying");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"MPMoviePlaybackStatePaused");
            break;
        case MPMoviePlaybackStateInterrupted:
            NSLog(@"MPMoviePlaybackStateInterrupted");
            break;
        case MPMoviePlaybackStateSeekingForward:
            NSLog(@"MPMoviePlaybackStateSeekingForward");
            break;
        case MPMoviePlaybackStateSeekingBackward:
            NSLog(@"MPMoviePlaybackStateSeekingBackward");
            break;
        default:
            break;
    }

}
/**
 *  现在的方法
 */
- (AVPlayerItem *)playerItem
{
    
    if (!_playerItem) {
        NSURL *url = self.movieURL;
        _playerItem = [AVPlayerItem playerItemWithURL:url];
    }
    
    return _playerItem;
}

- (AVPlayer *)player
{
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:self.playerItem];
    }
    return _player;
}

- (AVPlayerViewController *)avPlayer
{
    if (!_avPlayer) {
        // 负责控制媒体播放的控制器
        
        _avPlayer = [[AVPlayerViewController alloc]init];
        _avPlayer.player = self.player;
        
        _avPlayer.view.frame = self.view.bounds;

        
        [self.view addSubview:_avPlayer.view];
    }
    return _avPlayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.moviePlayer play];
//    [self addNotificaion];
    
    [self.avPlayer.player play];
//    [self.view addSubview:self.playerView];
//    [self.playerView.player play];
    
}

- (void)viewDidAppear:(BOOL)animated
{
//    self.moviePlayer.fullscreen = YES;
}
@end
