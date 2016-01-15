//
//  YTAVMovieViewController.h
//  0115媒体播放器
//
//  Created by Lynn on 16/1/15.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTAVMovieViewController;

@protocol YTAVMovieViewControllerDelegate <NSObject>

- (void)avMoviePlayerDidFinished:(YTAVMovieViewController *)movieViewController;
- (void)avMoviePlayerDidCapturedWithImage:(UIImage *)image;

@end

@interface YTAVMovieViewController : UIViewController

@property(nonatomic, strong) NSURL *movieURL;
@property(nonatomic, weak)id<YTAVMovieViewControllerDelegate> delegate;

/**
 *  截取指定时间的图像
 */
//- (void)captureImageAtTime:(float)time;
@end

