//
//  XUNavigationController.m
//  0131YTWeibo
//
//  Created by Lynn on 16/2/1.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "XUNavigationController.h"

@implementation XUNavigationController
/**
 *  第一次使用这个类的时候会调用（1个类只会调用1次）
 */
+ (void)initialize
{
    [super initialize];
    // 1. 设置导航栏主题
    [self setupNavBarTheme];
    
    // 2. 设置导航栏主题按钮
    [self setupBarButtonItem];

}
/**
 *  设置导航栏主题按钮
 */
+ (void)setupBarButtonItem
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    if (!iOS7) {
        // 设置背景
        [item setBackButtonBackgroundImage:[UIImage imageWithNamed:@"navigationbar_button_background"] forState:(UIControlStateNormal) barMetrics:(UIBarMetricsDefault)];
        [item setBackButtonBackgroundImage:[UIImage imageWithNamed:@"navigationbar_button_background_pushed"] forState:(UIControlStateSelected) barMetrics:(UIBarMetricsDefault)];
        [item setBackButtonBackgroundImage:[UIImage imageWithNamed:@"navigationbar_button_background_pushed_disable"] forState:(UIControlStateDisabled) barMetrics:(UIBarMetricsDefault)];
    }

    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //    textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textAttrs forState:(UIControlStateNormal)];
}


/**
 *  设置导航栏主题daolanlanyan
 */
+ (void)setupNavBarTheme
{
    // 取出appearence对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置背景
    if (!iOS7) {
        [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //    textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19];
    [navBar setTitleTextAttributes:textAttrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
@end
