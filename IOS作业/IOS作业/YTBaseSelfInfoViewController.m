//
//  YTBaseSelfInfoViewController.m
//  IOS作业
//
//  Created by zhu on 15/12/27.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "YTBaseSelfInfoViewController.h"
#import "YTSettingItem.h"
#import "YTSettingGroup.h"
#import "UIImage+Extension.h"

@interface YTBaseSelfInfoViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *textField;

@end

@implementation YTBaseSelfInfoViewController

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
    //[super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加主题的View
    [self addTitleView];
    self.titleLabel.text = @"昵称";
    self.titleFeild.text = self.item.title;
    self.titleFeild.enabled = NO;
    
    // 添加事件的View
    [self addEventView];
    self.subTitle.text = @"我的座右铭";

    // 添加确定按钮
    [self addFinishBtn];
    self.subTitleView.text = self.item.subtitle;
    self.subTitleView.editable = NO;
}

- (void)btnClicked
{
    if([self.delegate respondsToSelector:@selector(selfInfoViewController:didSaveInfo:)])
    {
        self.item.title = self.titleFeild.text;
        self.item.subtitle = self.subTitleView.text;
        [self.delegate selfInfoViewController:self didSaveInfo:self.item];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
