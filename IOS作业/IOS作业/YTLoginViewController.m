//
//  YTLoginViewController.m
//  IOS作业
//
//  Created by zhu on 15/12/24.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "YTLoginViewController.h"
#import "MBProgressHUD+MJ.h"



@interface YTLoginViewController()
@property (weak, nonatomic) IBOutlet UITextField *accountView;
@property (weak, nonatomic) IBOutlet UITextField *pwdView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UISwitch *rmbPWDSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

- (IBAction)rmbPWDChanged:(UISwitch *)sender;
- (IBAction)autoLoginChanged:(UISwitch *)sender;
- (IBAction)login:(UIButton *)sender;

@end

@implementation YTLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChanged) name:UITextFieldTextDidChangeNotification object:self.accountView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChanged) name:UITextFieldTextDidChangeNotification object:self.pwdView];
    
    UIImage* bg = [UIImage imageNamed:@"bg_login"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bg];

    [self textFiledChanged];
    
    // 读取上次配置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.accountView.text = [defaults objectForKey:YTAccountKey];
    self.rmbPWDSwitch.on = [defaults boolForKey:YTRmbPwdKey];
    self.autoLoginSwitch.on = [defaults boolForKey:YTAutoLoginKey];
    
    if (self.rmbPWDSwitch.isOn) {
        self.pwdView.text = [defaults objectForKey:YTPwdKey];
    }
    if (self.autoLoginSwitch.isOn) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self login:nil];
        });
        
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![self.accountView isExclusiveTouch] && ![self.pwdView isExclusiveTouch]) {
        [self.accountView resignFirstResponder];
        [self.pwdView resignFirstResponder];
        [self.view endEditing:YES];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textFiledChanged
{
    self.loginBtn.enabled = (self.accountView.text.length && self.pwdView.text.length);
}

- (IBAction)rmbPWDChanged:(UISwitch *)sender {
    if (!self.rmbPWDSwitch.isOn) {
        self.autoLoginSwitch.on = NO;
    }
}

- (IBAction)autoLoginChanged:(UISwitch *)sender {
    if (self.autoLoginSwitch.isOn) {
        self.rmbPWDSwitch.on = YES;
    }
}

- (IBAction)login:(UIButton *)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![self.accountView.text isEqualToString:[defaults objectForKey:YTAccountKey]]) {
        [MBProgressHUD showError:@"账号错误" toView:self.view];
        return;
    }
    if (![self.pwdView.text isEqualToString:[defaults objectForKey:YTPwdKey]]) {
        [MBProgressHUD showError:@"密码错误" toView:self.view];
    }
    // 存数数据
    
    [defaults setBool:self.rmbPWDSwitch.isOn forKey:YTRmbPwdKey];
    [defaults setBool:self.autoLoginSwitch.isOn forKey:YTAutoLoginKey];
    [defaults synchronize];
    
    [MBProgressHUD showMessage:@"加载中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),dispatch_get_main_queue(),^{
        [MBProgressHUD hideHUD];
        
        [self performSegueWithIdentifier:@"login2contact" sender:nil];
    });
}







































@end
