//
//  YTAVMovieViewController.m
//  0115媒体播放器
//
//  Created by Lynn on 16/1/15.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "YTAVMovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "YTPlayerView.h"
@interface YTAVMovieViewController ()


@property(nonatomic, strong) AVPlayerViewController *avPlayer;
@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) AVPlayerItem *playerItem;
@property(nonatomic, strong) YTPlayerView *playerView;

@property (nonatomic ,strong) id playbackTimeObserver;
@end

@implementation YTAVMovieViewController

/**
 *  现在的方法
 */

- (AVPlayerItem *)playerItem
{
    
    if (!_playerItem) {
        NSURL *url = self.movieURL;
        _playerItem = [AVPlayerItem playerItemWithURL:url];
        [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
        [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
        // 添加视频播放结束通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
    }
    return _playerItem;
}

- (void)moviePlayDidEnd:(NSNotification *)notification {
    NSLog(@"Play end");
    if ([self.delegate respondsToSelector:@selector(avMoviePlayerDidFinished:)]) {
        [self.delegate avMoviePlayerDidFinished:self];
    }
}


// KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");

        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
    }
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

    [self.avPlayer.player play];

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(avMoviePlayerDidFinished:)]) {
        [self.delegate avMoviePlayerDidFinished:self];
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    //    self.moviePlayer.fullscreen = YES;
}

- (void)dealloc {
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [self.playerView.player removeTimeObserver:self.playbackTimeObserver];
}
@end

