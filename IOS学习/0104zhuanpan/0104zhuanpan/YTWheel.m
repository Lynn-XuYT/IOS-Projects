//
//  YTWheel.m
//  0104zhuanpan
//
//  Created by Lynn on 16/1/4.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "YTWheel.h"
#import "YTViewButton.h"

@interface YTWheel()
@property (weak, nonatomic) IBOutlet UIImageView *centerWheel;
@property(nonatomic, strong) YTViewButton *btn;
@property(nonatomic, strong) CADisplayLink *link;


@end

@implementation YTWheel

+ (instancetype)wheel
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YTWheel" owner:nil options:nil] lastObject];
}

/**
 *  在这个方法中，取得的属性才是有值的
 */
- (void)awakeFromNib
{
    self.centerWheel.userInteractionEnabled = YES;
    
    // 加载大图
    UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *bigImagePressed = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    CGFloat smallImgW, smallImgH;
    if ([UIScreen mainScreen].scale == 2) {
        smallImgW = bigImage.size.width/12.0 *2;
        smallImgH = bigImage.size.height *2;
    }else
    {
        smallImgW = bigImage.size.width/12.0;
        smallImgH = bigImage.size.height;
    }

    
    for (int index = 0; index<12; index++) {
        YTViewButton *btn = [YTViewButton buttonWithType:UIButtonTypeCustom];
//        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        
        // 从大图中裁剪对应星座的图片
        CGImageRef smallImage = CGImageCreateWithImageInRect(bigImage.CGImage, CGRectMake( smallImgW * index, 0, smallImgW, smallImgH)) ;
        CGImageRef smallImagePressed = CGImageCreateWithImageInRect(bigImagePressed.CGImage, CGRectMake( smallImgW * index, 0, smallImgW, smallImgH)) ;
        [btn setImage:[UIImage imageWithCGImage:smallImage] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageWithCGImage:smallImagePressed] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        btn.bounds = CGRectMake(0, 0, 68, 143);
        // 设置锚点和位置
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
        // 设置旋转角度
        CGFloat angle = (30 * index) /180.0 *M_PI;
        btn.transform = CGAffineTransformMakeRotation(angle);
        
        // 监听按钮的点击
        self.btn = btn;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        
        [self.centerWheel addSubview:btn];
    }
    
}

- (void)btnClick:(YTViewButton*) btn
{
    self.btn.selected = NO;
    btn.selected = YES;
    self.btn = btn;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {

    }
    return self;
}
- (void)layoutSubviews
{
    
}

/**
 *  开始不停地旋转
 */
- (void)startRotating
{
    // 设置定时器 ,1秒内刷新60次
     self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//    CABasicAnimation *anim = [CABasicAnimation animation];
//    anim.keyPath = @"transform.rotation";
//    anim.toValue = @(2*M_PI);
//    anim.duration = 5.0;
//    anim.repeatCount = MAXFLOAT;
//    [self.centerWheel.layer addAnimation:anim forKey:nil];
}

- (void)update
{
    self.centerWheel.transform = CGAffineTransformRotate(self.centerWheel.transform, M_PI / 150);
}

- (void)stopRotating
{
    [self.link invalidate];
    self.link = nil;
}
/**
 *  开始选号
 */
- (IBAction)startChoose:(id)sender {
    [self stopRotating];
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(2 * M_PI * 3);
    
    anim.duration = 3.0;
    
    // 开头和结尾比较慢
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate = self;
    
    
    [self.centerWheel.layer addAnimation:anim forKey:nil];
    
    
    self.userInteractionEnabled = NO;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startRotating];
    });
}


@end
