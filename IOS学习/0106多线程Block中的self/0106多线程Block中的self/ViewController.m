//
//  ViewController.m
//  0106多线程Block中的self
//
//  Created by Lynn on 16/1/6.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"
#import "DemoObj.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DemoObj *obj = [[DemoObj alloc]init];
    [obj demoBlockOp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
