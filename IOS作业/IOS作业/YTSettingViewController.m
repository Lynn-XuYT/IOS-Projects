//
//  YTSettingViewController.m
//  IOS作业
//
//  Created by zhu on 15/12/24.
//  Copyright © 2015年 xu. All rights reserved.
//


#import "YTSettingViewController.h"
#import "MBProgressHUD+MJ.h"
#import "UIImage+Extension.h"
#import "YTSettingItem.h"
#import "YTSettingGroup.h"

#import "YTLoginViewController.h"

#import "YTSelfInfoViewController.h"
#import "YTAboutViewController.h"

#import "YTSelfInfo.h"
#import "YTBaseSelfInfoViewController.h"
#import "YTMottoViewController.h"
@interface YTSettingViewController()
@property (nonatomic, strong) NSMutableArray* info;
@property (weak, nonatomic) IBOutlet UIButton *LogoutBtn;
- (IBAction)logoutBtnClick:(UIButton *)sender;

@end

@implementation YTSettingViewController

/**
 *  数据
 */
- (void)setupGroup1
{
    YTSettingItem *me = [YTSettingItem itemWithIcon:@"me" title:@"XXXX" subtitle:@"我的座右铭" destVcClass:[YTSelfInfoViewController class]];
    
    YTSettingGroup *group = [[YTSettingGroup alloc] init];
    group.items = @[me];
    [self.data addObject:group];
}

- (void)setupGroup2
{
    YTSettingItem *other = [YTSettingItem itemWithTitle:@"其他设置" destVcClass:nil];
    
    YTSettingGroup *group = [[YTSettingGroup alloc] init];
    group.items = @[other];
    [self.data addObject:group];

}

- (void)setupGroup3
{
    YTSettingItem *share = [YTSettingItem itemWithTitle:@"分享" destVcClass:[YTSelfInfoViewController class]];
    YTSettingItem *check = [YTSettingItem itemWithTitle:@"检查新版本" destVcClass:nil];
    check.option = ^{
        // 弹框提示
        [MBProgressHUD showMessage:@"正在加载"];
        
        // 几秒后消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 移除HUD
            [MBProgressHUD hideHUD];
            
            // 提醒有没有新版本
            [MBProgressHUD showError:@"没有新版本"];
        });
    };
    YTSettingGroup *group = [[YTSettingGroup alloc] init];
    group.items = @[share, check];
    [self.data addObject:group];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.LogoutBtn setBackgroundImage:[UIImage resizableImage:@"navBg"] forState:UIControlStateNormal];
    
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}




#pragma mark 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!(indexPath.section == 0 && indexPath.row == 0)) {
        return 50;
    }
    return 65;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)logoutBtnClick:(UIButton *)sender {
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注销" message:@"确定要注销？" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:sure];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
