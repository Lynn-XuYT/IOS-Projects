//
//  YTMovieViewController.h
//  0115媒体播放器
//
//  Created by Lynn on 16/1/15.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTMovieViewController;
@protocol YTMovieViewControllerDelegate <NSObject>

- (void)moviePlayerDidFinished:(YTMovieViewController *)movieViewController;
- (void)moviePlayerDidCapturedWithImage:(UIImage *)image;

@end




@interface YTMovieViewController : UIViewController
@property(nonatomic, strong) NSURL *movieURL;
@property(nonatomic, weak)id<YTMovieViewControllerDelegate> delegate;
@end
