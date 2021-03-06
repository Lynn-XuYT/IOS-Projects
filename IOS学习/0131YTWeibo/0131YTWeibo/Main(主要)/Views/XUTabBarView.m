//
//  XUTabBarView.m
//  0131XUWeibo
//
//  Created by Lynn on 16/1/31.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "XUTabBarView.h"
#import "XUTabBarButton.h"

@interface XUTabBarView()

@property(nonatomic, weak) XUTabBarButton *selectedButton;
@end
@implementation XUTabBarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"tabbar_background"]];
        }
        
    }
    
    return self;
}
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 创建按钮
    XUTabBarButton *button = [[XUTabBarButton alloc] init];
    [self addSubview:button];
    
    // 设置数据
    button.item = item;
/*
 [button setTitle:item.title forState:UIControlStateNormal];
 [button setImage:item.image forState:UIControlStateNormal];
 [button setImage:item.selectedImage forState:UIControlStateSelected];
 [button setBackgroundImage:[UIImage imageWithNamed:@"tabbar_slider"] forState:UIControlStateSelected];
 */

    // 监听按钮的点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 默认选中第0个按钮
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听按钮的点击
 */
- (void)buttonClick:(XUTabBarButton *)button
{
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int index = 0; index<self.subviews.count; index++) {
        // 取出按钮
        XUTabBarButton *button = self.subviews[index];
        button.tag = index;
        // 设置按钮的frame
        CGFloat buttonX = index * buttonW;
        CGFloat buttonY = 0;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}
@end
