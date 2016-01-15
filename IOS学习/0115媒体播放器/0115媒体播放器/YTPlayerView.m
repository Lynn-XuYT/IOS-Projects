//
//  YTPlayerView.m
//  0115媒体播放器
//
//  Created by Lynn on 16/1/15.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "YTPlayerView.h"

@implementation YTPlayerView
+(Class)layerClass
{
    return [AVPlayerLayer class];
}

- (AVPlayer *)player
{
    return [(AVPlayerLayer *)[self layer] player];
}
- (void)setPlayer:(AVPlayer *)player
{
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}
@end
