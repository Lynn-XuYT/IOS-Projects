//
//  ViewController.m
//  16-QQ好友列表
//
//  Created by zhu on 15/11/22.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "ViewController.h"
#import "MJFriendGroup.h"
#import "MJFriend.h"
#import "MJHeaderView.h"
#import "MJFriendCell.h"

@interface ViewController ()<MJHeaderViewDelegate>


@end

@implementation ViewController

- (NSArray *)group
{
    if (_group == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil]];
        NSMutableArray *groupArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            MJFriendGroup *group = [MJFriendGroup groupWithDict:dict];
            [groupArray addObject:group];
        }
        _group = groupArray;
    }
    return _group;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 每一行cell的高度
    self.tableView.rowHeight = 50;
    // 每一组头部控件的高度
    self.tableView.sectionHeaderHeight = 44;
}


#pragma 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.group.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MJFriendGroup *grou = self.group[section];
    return (grou.isOpened ? grou.friends.count:0);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    MJFriendCell *cell = [MJFriendCell cellWithTableview:tableView];
    
    // 设置cell数据
    MJFriendGroup *grou = self.group[indexPath.section];
    MJFriend *friend = grou.friends[indexPath.row];
    cell.friendData = friend;
    
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 创建头部控件
    MJHeaderView *header = [MJHeaderView headerViewWithTableView:tableView];
    
    // 给header设置数据(创建传递模型)
    header.group = self.group[section];
    header.delegate = self;
    
    [header didMoveToSuperview];
    
    return header;
}
#pragma headerView的代理方法
- (void)headerViewDidClickName:(MJHeaderView *)headerView
{
    [self.tableView reloadData];
    
}
// 设置每一行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
