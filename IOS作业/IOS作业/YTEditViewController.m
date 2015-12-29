//
//  MJEditViewController.m
//  IOS作业
//
//  Created by zhu on 15/12/28.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "YTEditViewController.h"
#import "UIImage+Extension.h"
#import "YTMemo.h"
#import "YTMemoFrame.h"
@interface YTEditViewController ()

@end

@implementation YTEditViewController

- (void)loadView
{
    
    [super loadView];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(leftButtonClick)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)leftButtonClick
{
    self.titleFeild.enabled = YES;
    self.subTitleView.editable = YES;
    [self.titleFeild becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleFeild.enabled = NO;
    self.titleFeild.text = self.memoFrame.memo.title;

    self.subTitleView.editable = NO;
    self.subTitleView.text = self.memoFrame.memo.substitle;
    
    self.timeLabel.text = self.memoFrame.memo.time;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)btnClicked
{
    if([self.delegate respondsToSelector:@selector(editViewController:didSaveInfo:)])
    {
        //YTMemoFrame
        self.memoFrame.memo.title = self.titleFeild.text;
        self.memoFrame.memo.substitle = self.subTitleView.text;
        self.memoFrame.memo.time = self.timeLabel.text;
        [self.delegate editViewController:self didSaveInfo:self.memoFrame];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
