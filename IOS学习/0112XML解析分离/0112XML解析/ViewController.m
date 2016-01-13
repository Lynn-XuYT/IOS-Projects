//
//  ViewController.m
//  0112XML解析
//
//  Created by Lynn on 16/1/12.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"
#import "YTBook.h"
@interface ViewController ()<NSXMLParserDelegate>


@end

@implementation ViewController

- (void)setBooksList:(NSArray *)booksList
{
    _booksList = booksList;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 加载数据方法
    [self loadData];
}
- (IBAction)loadData
{
    // 开始显示刷新控件
    [self.refreshControl beginRefreshing];

}


#pragma mark - 表格的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.booksList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 设置表格数据
    YTBook *book = self.booksList[indexPath.row];
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.author;
    
    return cell;
}

@end
