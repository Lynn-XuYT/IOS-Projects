//
//  XUHomeTableViewController.m
//  XUWeibo
//
//  Created by Lynn on 16/1/31.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "XUHomeTableViewController.h"
#import "UIBarButtonItem+XU.h"
#import "XUTitileButton.h"
#import "AFNetworking.h"
#import "XUAccountTool.h"
#import "XUAccount.h"
#import "UIImageView+WebCache.h"
#import "XUStatus.h"
#import "MJExtension.h"

#define XUTitleButtonDownTag 0
#define XUTitleButtonUpTag -1
@interface XUHomeTableViewController ()
@property(nonatomic, strong) NSArray *statuses;
@end

@implementation XUHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavItem];
    
    [self setupStatusData];
}

/**
 *  加载微博数据
 */
- (void)setupStatusData
{
    // 创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XUAccountTool account].access_token;
    // 发送网络请求
    [mgr GET:@"https://api.weibo.com/2/statuses/public_timeline.json" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XULog(@"json==== %@",responseObject);
        
        // 取出所有的微博数据
//        NSArray *dictArray = responseObject[@"statuses"];
//        NSMutableArray *statusesArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            // 创建模型
//            XUStatus *status = [XUStatus objectWithKeyValues:dict];
//            // 添加模型
//            [statusesArray addObject:status];
//        }
//        self.statuses = statusesArray;
        self.statuses = [XUStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 隐藏提醒框
        NSLog(@"%@",error);
    }];
    
}
- (void)setupNavItem
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 左边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 中间按钮
    XUTitileButton *titleButton = [[XUTitileButton alloc]init];
    titleButton.tag = XUTitleButtonDownTag;
    // 图标
    [titleButton setImage:[UIImage imageWithNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 文字
    [titleButton setTitle:@"hahah" forState:(UIControlStateNormal)];
    [titleButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    titleButton.frame = CGRectMake(0, 0, 80, 30);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}
- (void)titleClick:(XUTitileButton *)titleButton
{

    if (titleButton.tag == XUTitleButtonDownTag) {
        [titleButton setImage:[UIImage imageWithNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag = XUTitleButtonUpTag;
    }else
    {
        [titleButton setImage:[UIImage imageWithNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag = XUTitleButtonDownTag;
    }
    
}
- (void)findFriend
{
    XULog(@"findFriend");
}
- (void)pop
{
    XULog(@"pop");
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statuses.count;
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    // 设置cell的数据
    
    // 微薄的文字
    XUStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    
    // 微博作者的昵称
    XUUser *user = status.user;
    cell.detailTextLabel.text = user.name;
    
    // 微博坐着的头像
    NSString *iconUrl = user.profile_image_url;

    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageWithNamed:@"album"] options:0 completed:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
 //   vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
