//
//  ViewController.m
//  0104AnimationInUIView
//
//  Created by Lynn on 16/1/4.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) CALayer *layer;

@property(nonatomic, strong) UIView *myview;
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, assign) int index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    // 创建一个图层
//    CALayer *layer = [[CALayer alloc]init];
//    layer.position = CGPointMake( 150, 150);
//    layer.bounds = CGRectMake(0, 0, 150, 150);
//    layer.backgroundColor = [UIColor redColor].CGColor;
//    [self.view.layer addSublayer:layer];
//    self.layer = layer;
    
    // 创建一个UIView
    UIView *myview = [[UIView alloc]init];
    myview.frame = CGRectMake(300, 300, 150, 150);
    myview.backgroundColor = [UIColor redColor];
    [self.view addSubview:myview];
    self.myview = myview;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(20, 20, 320, 400);
    NSString *path = [NSString stringWithFormat:@"%d.jpg",self.index+1];
    imageView.image = [UIImage imageNamed:path];
    [self.view addSubview:imageView];
    self.imgView = imageView;

    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.index ++;
    if (self.index == 9) {
        self.index = 0;
    }
    NSString *path = [NSString stringWithFormat:@"%d.jpg",self.index+1];
    self.imgView.image = [UIImage imageNamed:path];
    
    // UIView 的转场动画
    [UIView transitionWithView:self.imgView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
}

- (void)testViewSimpleAnim
{
    /**
     *  第一种动画
     */
    [UIView beginAnimations:nil context:nil];
    // 监听动画动画执行完成
    self.myview.center = CGPointMake(0,0);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationStop)];
    [UIView commitAnimations];
    
    /**
     *  第二种
     */
    [UIView animateWithDuration:1.0 animations:^{
        self.myview.center = CGPointMake(200, 400);
    } completion:^(BOOL finished){// 监听动画执行完成
        NSLog(@"animationStop2");
    }];
}
- (void)animationStop
{
    NSLog(@"animationStop1");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
