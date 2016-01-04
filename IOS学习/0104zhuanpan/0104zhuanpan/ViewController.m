//
//  ViewController.m
//  0104zhuanpan
//
//  Created by Lynn on 16/1/4.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"
#import "YTWheel.h"
@interface ViewController ()
@property(nonatomic, strong) YTWheel *wheel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.wheel = [YTWheel wheel];
    self.wheel.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.5);
    
    [self.view addSubview:self.wheel];
    
    UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
    btnStart.frame = CGRectMake(50, 50, 100, 50);
    btnStart.backgroundColor = [UIColor redColor];
    [btnStart setTitle:@"开始" forState:UIControlStateNormal];
    [btnStart addTarget:self action:@selector(btnStartClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnStart];
    
    UIButton *btnStop = [UIButton buttonWithType:UIButtonTypeCustom];
    btnStop.frame = CGRectMake(250, 50, 100, 50);
    btnStop.backgroundColor = [UIColor redColor];
    [btnStop setTitle:@"停止" forState:UIControlStateNormal];
    [btnStop addTarget:self action:@selector(btnStopClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnStop];
}

- (void)btnStartClick
{
    [self.wheel startRotating];
}

- (void)btnStopClick
{
    [self.wheel stopRotating];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
