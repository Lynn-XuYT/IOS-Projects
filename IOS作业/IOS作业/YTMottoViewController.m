//
//  YTMottoViewController.m
//  IOS作业
//
//  Created by zhu on 15/12/27.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "YTMottoViewController.h"
#import "YTSettingItem.h"
#import "UIImage+Extension.h"
@interface YTMottoViewController ()<UITextViewDelegate>
@property(nonatomic, strong)UITextView* textView;
@property(nonatomic,strong)UIButton *btn;
@end

@implementation YTMottoViewController
- (void)leftButtonClick
{
    self.textView.editable = YES;
    [self.textView becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView* view = [[UIView alloc]init];
    view.layer.cornerRadius = 10;
    view.frame = CGRectMake(0, 90, self.view.frame.size.width, 365);
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, 5, view.frame.size.width-20, 30);
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"我的座右铭";
    [view addSubview:label];
    
    self.textView = [[UITextView alloc]init];
    
    self.textView.frame = CGRectMake(10, 45, view.frame.size.width-20, 300);
    self.textView.backgroundColor = [UIColor redColor];
    //[self.textView setBorderStyle:UITextBorderStyleRoundedRect];
    //self.textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.delegate = self;
    self.textView.editable = NO;
    self.textView.text = self.item.subtitle;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged) name:UITextViewTextDidChangeNotification object:self.textView];
    [view addSubview:self.textView];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(20, self.view.center.y*1.5, view.frame.size.width-40, 50);
    self.btn.layer.cornerRadius = 10;
    self.btn.enabled = NO;
    [self.btn setBackgroundImage:[UIImage resizableImage:@"navBg"] forState:UIControlStateNormal];
    [self.btn setTitle:@"确定" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
}

- (void)btnClicked
{
    if([self.delegate respondsToSelector:@selector(selfInfoViewController:didSaveInfo:)])
    {
        self.item.subtitle = self.textView.text;
        NSLog(@"%@",self.item.subtitle);
        [self.delegate selfInfoViewController:self didSaveInfo:self.item];
        
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)textViewChanged
{
    self.btn.enabled = (self.textView.text.length);
}


- (BOOL)textFieldShouldReturn:(UITableView *)textView
{
    [self.textView resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![self.textView isExclusiveTouch]) {
        [self.textView resignFirstResponder];
        [self.view endEditing:YES];
    }
}
@end
