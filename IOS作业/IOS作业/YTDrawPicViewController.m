//
//  YTDrawPicViewController.m
//  IOS作业
//
//  Created by Lynn on 15/12/30.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "YTDrawPicViewController.h"
#import "UIImage+Extension.h"
#import "YTDrawPicView.h"
#import "MBProgressHUD+MJ.h"

@interface YTDrawPicViewController ()
@property (strong, nonatomic) YTDrawPicView *drawView;
@end

@implementation YTDrawPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizableImage:@"bg"]];
    
    CGFloat viewX = 20;
    CGFloat viewY = 95;
    CGFloat viewW = 335;
    CGFloat viewH = 520;
    
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizableImage:@"navBg"]];
    view.layer.cornerRadius = 5;
    [self.view addSubview:view];
    
    CGFloat subviewW = 315;
    
    CGFloat subviewH = 40;
    CGFloat padding = 10;
    UIView *subview = [[UIView alloc]init];
    subview.frame = CGRectMake(padding, padding, subviewW, subviewH);
    subview.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizableImage:@"navBg"]];
    subview.layer.cornerRadius = 5;
    [view addSubview:subview];
    
    
    // 添加按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 105, 40);
    [self setBtnStyle:backBtn];
    [backBtn setTitle:@"回退" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [subview addSubview:backBtn];
    
    // 重画
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(105, 0, 105, 40);
    [self setBtnStyle:clearBtn];
    [clearBtn setTitle:@"重画" forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearBtntnClicked) forControlEvents:UIControlEventTouchUpInside];
    [subview addSubview:clearBtn];
    
    // 保存
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(210, 0, 105, 40);
    saveBtn.layer.cornerRadius = 5;
    [self setBtnStyle:saveBtn];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [subview addSubview:saveBtn];
    
    _drawView = [[YTDrawPicView alloc]init];
    _drawView.frame = CGRectMake(padding, subviewH + padding + padding, subviewW, viewH - subviewH-padding*3);
    _drawView.backgroundColor = [UIColor whiteColor];
    _drawView.layer.cornerRadius = 10;
    _drawView.clipsToBounds = YES;
    [view addSubview:_drawView];
}

- (void)backBtnClicked
{
    [self.drawView back];
    
}

- (void)clearBtntnClicked
{
    [self.drawView clear];
    
}

- (void)saveBtnClicked
{
    // 截图
    UIImage *image = [UIImage captureWithView:self.drawView];
    
    // 保存到图片
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/**
 保存图片操作之后就会调用
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) { // 保存失败
        [MBProgressHUD showError:@"保存失败"];
    } else { // 保存成功
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}


- (void)setBtnStyle:(UIButton *)btn
{
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizableImage:@"bg"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizableImage:@"navBg"] forState:UIControlStateHighlighted];
}


@end
