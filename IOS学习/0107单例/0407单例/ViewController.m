//
//  ViewController.m
//  0407单例
//
//  Created by Lynn on 16/1/7.
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
    
    
    DemoObj *obj1 = [[DemoObj alloc]init];
    DemoObj *obj2 = [[DemoObj alloc]init];
    DemoObj *obj3 = [[DemoObj alloc]init];
    NSLog(@"%@",obj1);
    NSLog(@"%@",obj2);
    NSLog(@"%@",obj3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end
