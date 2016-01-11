//
//  ViewController.m
//  0107NSObject多线程方法
//
//  Created by Lynn on 16/1/7.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSString *imagePath;
@end

@implementation ViewController
// 0. 模拟路径加载路径
- (void)setImagePath:(NSString *)imagePath
{
    NSLog(@"%@", [NSThread currentThread]);
    // 模拟下载，延时
    [NSThread sleepForTimeInterval:5];
    
    // 设置图像
    // 在主线程中更新UI
    // YES 会阻塞线程，NO不会
    [self performSelectorOnMainThread:@selector(setImage:) withObject:[UIImage imageNamed:imagePath] waitUntilDone:YES];
    
    // self.image = [UIImage imageNamed:imagePath];
}
// 1. 图像
- (void)setImage:(UIImage *)image
{
    NSLog(@"%@", [NSThread currentThread]);
    self.imageView.image = image;
    // 根据图像自动调整大小
    [self.imageView sizeToFit];
    
}

// 2. 创建imageView
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.imageView];
    
    // 后台运行
    [self performSelectorInBackground:@selector(setImagePath:) withObject:@"img1"];
    //self.imagePath = @"img1";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
