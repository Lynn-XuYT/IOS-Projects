//
//  YTTabBarController.m
//  iOS大作业
//
//  Created by zhu on 15/12/23.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "YTTabBarController.h"
#import "YTTabBar.h"
#import "UIImage+Extension.h"

@interface YTTabBarController ()<YTTabBarDelegate>
@end

@implementation YTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加自定义TabBar
    YTTabBar *myTabBar = [[YTTabBar alloc] init];
    myTabBar.frame = self.tabBar.bounds;
    myTabBar.backgroundColor = [UIColor whiteColor];
    
    myTabBar.delegate = self;
    
    [self.tabBar addSubview:myTabBar];
    
    // 添加对应个数的按钮
    for (int  i = 0; i<self.viewControllers.count; i++) {
        NSString* name = [NSString stringWithFormat:@"TabBar0%d",i+1];
        NSString* selName = [NSString stringWithFormat:@"TabBarSel0%d",i+1];
        [myTabBar addTabBarButtonWithName:name selName:selName];
    }

}

- (void)tabBar:(YTTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to
{
    // 选中最新的控制器
    self.selectedIndex = to;
}


@end
