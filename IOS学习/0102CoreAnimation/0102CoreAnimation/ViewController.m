//
//  ViewController.m
//  0102CoreAnimation
//
//  Created by Lynn on 16/1/5.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define Angle2Radian(angle) ((angle) /180.0 * M_PI)

@interface ViewController ()
@property(nonatomic, strong) CALayer* layer;

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, assign) int index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CALayer *layer = [CALayer layer];
    layer.position = CGPointMake(100, 100);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img1"]].CGColor;
    //layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    // 创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    // 设置动画对象
    // keyPath 决定了执行怎样的动画，调整那个属性来执行动画
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(M_PI);
    
    // 创建动画对象
    CABasicAnimation *anim2 = [CABasicAnimation animation];
    
    // 设置动画对象
    // keyPath 决定了执行怎样的动画，调整那个属性来执行动画
    anim2.keyPath = @"transform.scale";
    anim2.toValue = @(0.5);
    
    group.animations = @[anim,anim2];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:group forKey:nil];
}

/**
 *  CATransition
 */
- (void)testTransition
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(23, 50, 320, 480)];
    NSString *filePath = [NSString stringWithFormat:@"%d.jpg",self.index+1];
    UIImage *image = [UIImage imageNamed:filePath];
    imageView.image = image;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 550, 100, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"上一张" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(previous) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(200, 550, 100, 50);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"下一张" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)previous
{
    self.index--;
    if (self.index == -1) {
        self.index = 8;
    }
    NSString *filePath = [NSString stringWithFormat:@"%d.jpg",self.index+1];
    UIImage *image = [UIImage imageNamed:filePath];
    self.imageView.image = image;
    
    // 转场动画
    CATransition *anim = [CATransition animation];
    anim.type = @"cube";
    anim.subtype = kCATransitionFromLeft;
    anim.duration = 0.5;
    [self.imageView.layer addAnimation:anim forKey:nil];
}
- (void)next
{
    self.index++;
    if (self.index == 8) {
        self.index = 0;
    }
    NSString *filePath = [NSString stringWithFormat:@"%d.jpg",self.index+1];
    UIImage *image = [UIImage imageNamed:filePath];
    self.imageView.image = image;
    
    // 转场动画
    CATransition *anim = [CATransition animation];
    anim.type = @"cube";
    anim.subtype = kCATransitionFromRight;
    anim.duration = 0.5;
    [self.imageView.layer addAnimation:anim forKey:nil];
}

/**
 *  窗口抖动
 */
- (void)shake
{
    
    CALayer *layer = [CALayer layer];
    layer.position = CGPointMake(100, 100);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img1"]].CGColor;
    //layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 200, 100, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(beginClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(200, 200, 100, 50);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"停止" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(endClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}
- (void)beginClickBtn
{
    NSLog(@"beginClickBtn");
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    
    anim.values = @[@(Angle2Radian(-5)), @(Angle2Radian(0)),@(Angle2Radian(5))];
    anim.repeatCount = MAXFLOAT;
    
    anim.duration = 0.2;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:anim forKey:@"shake"];
}

- (void)endClickBtn
{
    NSLog(@"endClickBtn");
    [self.layer removeAnimationForKey:@"shake"];
}



/**
 *  CAKeyframeAnimation
 */
- (void)testKeyPath
{
    // 创建动画对象
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    // 设置动画对象
    // keyPath 决定了执行怎样的动画，调整那个属性来执行动画
    anim.keyPath = @"position";
    
    anim.duration = 2.0;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 200, 200));
    anim.path = path;
    CGPathRelease(path);
    
    // 设置动画的节奏
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // 设置代理
    anim.delegate = self;
    /**
     *  让图层保持动画执行完毕后的效果
     *  这两个属性联合使用才会有效
     */
    // 动画执行完毕后不要删除动画
    anim.removedOnCompletion = NO;
    // 保持最新状态
    anim.fillMode = kCAFillModeForwards;
    // 添加动画
    [self.layer addAnimation:anim forKey:nil];
    
}
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animationDidStart");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop");
}

- (void)testKeyTranslation
{
    // 创建动画对象
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    // 设置动画对象
    // keyPath 决定了执行怎样的动画，调整那个属性来执行动画
    anim.keyPath = @"position";
    
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointZero];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(150, 150)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    anim.values = @[v1, v3, v2];
    
    anim.duration = 2.0;
    anim.keyTimes = @[@(0.5), @(1.5)];
    /**
     *  让图层保持动画执行完毕后的效果
     *  这两个属性联合使用才会有效
     */
    // 动画执行完毕后不要删除动画
    anim.removedOnCompletion = NO;
    // 保持最新状态
    anim.fillMode = kCAFillModeForwards;
    
    // 添加动画
    [self.layer addAnimation:anim forKey:nil];
}

/**
 *  CABasicAnimation
 */
- (void)testTransform
{
    // 创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    // 设置动画对象
    // keyPath 决定了执行怎样的动画，调整那个属性来执行动画
    anim.keyPath = @"transform";
    //    anim.fromValue = ;
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 1)];
    anim.duration = 2.0;
    
    /**
     *  让图层保持动画执行完毕后的效果
     *  这两个属性联合使用才会有效
     */
    // 动画执行完毕后不要删除动画
    anim.removedOnCompletion = NO;
    // 保持最新状态
    anim.fillMode = kCAFillModeForwards;
    
    // 添加动画
    [self.layer addAnimation:anim forKey:nil];
}
- (void)testTranslate
{
    // 创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    // 设置动画对象
    // keyPath 决定了执行怎样的动画，调整那个属性来执行动画
    anim.keyPath = @"position";
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    anim.duration = 2.0;
    
    /**
     *  让图层保持动画执行完毕后的效果
     *  这两个属性联合使用才会有效
     */
    // 动画执行完毕后不要删除动画
    anim.removedOnCompletion = NO;
    // 保持最新状态
    anim.fillMode = kCAFillModeForwards;
    
    // 添加动画
    [self.layer addAnimation:anim forKey:nil];
}

@end
