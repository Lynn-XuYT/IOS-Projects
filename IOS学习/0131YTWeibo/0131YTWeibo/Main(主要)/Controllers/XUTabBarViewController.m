//
//  XUTabBarViewController.m
//  XUWeibo
//
//  Created by Lynn on 16/1/31.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "XUTabBarViewController.h"
#import "XUDiscoverTableViewController.h"
#import "XUHomeTableViewController.h"
#import "XUMessageTableViewController.h"
#import "XUMeTableViewController.h"
#import "UIImage+XU.h"
#import "XUTabBarView.h"
#import "XUNavigationController.h"
@interface XUTabBarViewController ()<XUTabBarViewDelegate>
@property(nonatomic, weak) XUTabBarView* customTabBar;
@end

@implementation XUTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化tabBar
    [self setupTabBar];
    
    // 初始化所有子控制器
    [self setupAllChildViewControllers];


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
/**
 *  初始化tabBar
 */
- (void)setupTabBar
{
    XUTabBarView *customTabBar = [[XUTabBarView alloc]init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}
/**
 *  初始化所有子控制器
 */
- (void)setupAllChildViewControllers
{
    
    // 首页
    XUHomeTableViewController *home = [[XUHomeTableViewController alloc]init];
    home.tabBarItem.badgeValue = @"99999";
    [self setupChildViewController:home title:@"首页" imageNamed:@"tabbar_home" selectImageNamed:@"tabbar_home_selected"];
    
    // 消息
    XUMessageTableViewController *message = [[XUMessageTableViewController alloc]init];
    message.tabBarItem.badgeValue = @"99999";

    [self setupChildViewController:message title:@"消息" imageNamed:@"tabbar_message_center" selectImageNamed:@"tabbar_message_center_selected"];
    
    // 广场
    XUDiscoverTableViewController *discover = [[XUDiscoverTableViewController alloc]init];
    discover.tabBarItem.badgeValue = @"9";
    [self setupChildViewController:discover title:@"广场" imageNamed:@"tabbar_discover" selectImageNamed:@"tabbar_discover_selected"];
        
    // 我
    XUMeTableViewController *me = [[XUMeTableViewController alloc]init];
    me.tabBarItem.badgeValue = @"99";
    [self setupChildViewController:me title:@"我" imageNamed:@"tabbar_profile" selectImageNamed:@"tabbar_profile_selected"];


}

/**
 *  创建子控制器
 *
 *  @param childVC          自控制器
 *  @param title            标题
 *  @param imageNamed       默认图片
 *  @param selectImageNamed 选中图片
 */
- (void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageNamed:(NSString *)imageNamed selectImageNamed:(NSString *)selectImageNamed
{
    // 设置控制器属性
    childVC.title = title;
    //    childVC.tabBarItem.title = @"首页";
    //    childVC.navigationItem.title = @"首页";
    
    // 设置图标
    childVC.tabBarItem.image =[UIImage imageWithNamed:imageNamed];
    if (iOS7) {
        // 去掉默认的选中图片的渲染方案
        childVC.tabBarItem.selectedImage = [[UIImage imageWithNamed:selectImageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else
    {
        childVC.tabBarItem.selectedImage = [UIImage imageWithNamed:selectImageNamed];
    }

    // 包装一个导航控制器
    XUNavigationController *navChildVC = [[XUNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:navChildVC];
    
    // 添加tabBar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVC.tabBarItem];
}

#pragma mark - XUTabBarViewDelegate的代理方法
/**
 *  切换控制器
 */
- (void)tabBar:(XUTabBarView *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}
@end
