//
//  YTSignUpViewController.m
//  IOS作业
//
//  Created by zhu on 15/12/24.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "YTSignUpViewController.h"
#import "MBProgressHUD+MJ.h"
@interface YTSignUpViewController()

- (IBAction)returnBtnClick:(UIButton *)sender;

- (IBAction)signUpBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField1;
@property (weak, nonatomic) IBOutlet UITextField *pwdField2;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;

@end

@implementation YTSignUpViewController

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChanged) name:UITextFieldTextDidChangeNotification object:self.accountField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChanged) name:UITextFieldTextDidChangeNotification object:self.pwdField1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChanged) name:UITextFieldTextDidChangeNotification object:self.pwdField2];

    
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![self.accountField isExclusiveTouch] && ![self.pwdField1 isExclusiveTouch] && ![self.pwdField2 isExclusiveTouch]) {
        [self.accountField resignFirstResponder];
        [self.pwdField1 resignFirstResponder];
        [self.pwdField2 resignFirstResponder];
        
        [self.view endEditing:YES];
    }
}

- (void)textFiledChanged
{
    self.signUpBtn.enabled = (self.accountField.text.length && self.pwdField1.text.length && self.pwdField2.text.length);
}

- (IBAction)returnBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signUpBtnClick:(UIButton *)sender {
    if (![self.pwdField1.text isEqualToString:self.pwdField2.text]) {
        [MBProgressHUD showError:@"密码输入不一致" toView:self.view];
        return;
    }
    // 存数数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.pwdField1.text forKey:YTPwdKey];
    [defaults setObject:self.accountField.text forKey:YTAccountKey];
    [defaults synchronize];
    
    [MBProgressHUD showMessage:@"注册成功"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),dispatch_get_main_queue(),^{
        [MBProgressHUD hideHUD];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
    
}
@end
