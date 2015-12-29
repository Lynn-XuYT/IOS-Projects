//
//  MJEditViewController.h
//  IOS作业
//
//  Created by zhu on 15/12/28.
//  Copyright © 2015年 xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTBaseMemoViewController.h"
@class YTMemoFrame,YTEditViewController;

@protocol YTEditViewControllerDelegate <NSObject>

@optional
- (void)editViewController:(YTEditViewController *)editMemoVc didSaveInfo:(YTMemoFrame *)memoFrame;

@end

@interface YTEditViewController : YTBaseMemoViewController
@property (nonatomic, strong) YTMemoFrame *memoFrame;
@property (nonatomic, strong) id<YTEditViewControllerDelegate> delegate;
@end
