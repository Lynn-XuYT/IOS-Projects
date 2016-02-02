//
//  XUTitileButton.m
//  0131YTWeibo
//
//  Created by Lynn on 16/2/1.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "XUTitileButton.h"

#define XUTitileButtonImageW 20
@implementation XUTitileButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 高亮的时候不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        // 设置居中样式
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.imageView.contentMode = UIViewContentModeCenter;
        // 背景
        [self setBackgroundImage:[UIImage resizeImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{

    CGFloat imageY = 0;
    CGFloat imageW = XUTitileButtonImageW;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = contentRect.size.width-imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - XUTitileButtonImageW;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleX = 0;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end
