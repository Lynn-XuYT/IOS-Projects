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

#import "YTMovieViewController.h"

#define ICONURL @"http://localhost/res/"
@interface ViewController ()<MJHeaderViewDelegate,MJFriendCellDelegate,YTMovieViewControllerDelegate>
@property(nonatomic, strong) YTMovieViewController *movieViewController;
@property(nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation ViewController

- (MJFriend *)selectFriend
{
    self.indexPath = self.tableView.indexPathForSelectedRow;
    int section = (int)self.indexPath.section;
    int row = (int)self.indexPath.row;
    MJFriendGroup *group = self.group[section];
    return group.friends[row];
}
- (YTMovieViewController *)movieViewController
{
    if (!_movieViewController) {
        _movieViewController = [[YTMovieViewController alloc] init];
        _movieViewController.delegate = self;

        MJFriend *friend = [self selectFriend];
        _movieViewController.movieURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ICONURL,friend.movieURL]];
        NSLog(@"%@",_movieViewController.movieURL);
        [_movieViewController captureImageAtTime:5.0];
    }
    
    return _movieViewController;
}
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
    MJFriendCell *cell = [MJFriendCell cellWithTableview:tableView atIndexPath:indexPath];
    cell.indexPath = indexPath;
    // 设置cell数据
    MJFriendGroup *grou = self.group[indexPath.section];
    MJFriend *friend = grou.friends[indexPath.row];
    cell.delegateCell = self;
    cell.friendData = friend;

    return cell;
}

- (void)cell:(MJFriendCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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


- (void)moviePlayerDidFinished:(YTMovieViewController *)movieViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.movieViewController = nil;
}

- (void)moviePlayerDidCapturedWithImage:(UIImage *)image
{
    MJFriend *friend = [self selectFriend];
    friend.image = image;
    NSIndexPath *indexPath = self.indexPath;
    NSLog(@"+++++++%@",indexPath);
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView reloadData];
}
#pragma mark - tableView 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self presentViewController:self.movieViewController animated:YES completion:nil];
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
