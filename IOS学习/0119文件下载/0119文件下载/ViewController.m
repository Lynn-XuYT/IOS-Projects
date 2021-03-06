//
//  ViewController.m
//  0119文件下载
//
//  Created by Lynn on 16/1/19.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"
#import "YTFiledownload.h"

@interface ViewController ()
@property(nonatomic, strong) YTFiledownload *download;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.download = [[YTFiledownload alloc] init];
    
    [self.download downloadFileWithURL:[NSURL URLWithString:@"http://localhost/res/002.png"] completion:^(UIImage *image){
        self.imageView.image = image;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
