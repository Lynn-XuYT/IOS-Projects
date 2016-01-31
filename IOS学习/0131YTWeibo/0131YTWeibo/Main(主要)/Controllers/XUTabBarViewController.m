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
@interface XUTabBarViewController ()

@end

@implementation XUTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化所有子控制器
    [self setupAllChildViewControllers];

    
}
- (void)setupAllChildViewControllers
{
    
    // 首页
    XUHomeTableViewController *home = [[XUHomeTableViewController alloc]init];
    [self setupChildViewController:home title:@"首页" imageNamed:@"tabbar_home" selectImageNamed:@"tabbar_home_selected"];
    
    // 消息
    XUMessageTableViewController *message = [[XUMessageTableViewController alloc]init];
    [self setupChildViewController:message title:@"消息" imageNamed:@"tabbar_message_center" selectImageNamed:@"tabbar_message_center_selected"];
    
    // 广场
    XUDiscoverTableViewController *discover = [[XUDiscoverTableViewController alloc]init];
    [self setupChildViewController:discover title:@"广场" imageNamed:@"tabbar_discover" selectImageNamed:@"tabbar_discover_selected"];
        
    // 我
    XUMeTableViewController *me = [[XUMeTableViewController alloc]init];
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
    UINavigationController *navChildVC = [[UINavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:navChildVC];
}

@end
