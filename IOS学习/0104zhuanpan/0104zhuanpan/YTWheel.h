//
//  YTWheel.h
//  0104zhuanpan
//
//  Created by Lynn on 16/1/4.
//  Copyright © 2016年 Lynn. All rights reserved.
//  大转盘

#import <UIKit/UIKit.h>

@interface YTWheel : UIView


+ (instancetype)wheel;
- (void)startRotating;
- (void)stopRotating;
- (IBAction)startChoose:(id)sender;


@end
