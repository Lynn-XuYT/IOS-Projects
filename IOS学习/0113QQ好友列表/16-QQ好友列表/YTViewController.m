//
//  YTViewController.m
//  16-QQ好友列表
//
//  Created by Lynn on 16/1/13.
//  Copyright © 2016年 xu. All rights reserved.
//

#import "YTViewController.h"
#import "MJFriendGroup.h"

@interface YTViewController()


@end

@implementation YTViewController

@synthesize group = _group;

- (void)setGroup:(NSArray *)group
{
    _group = group;
    [self.tableView reloadData];
}
- (NSArray *)group
{
    if (_group == nil) {
        // 访问网络，获取网络数据
        
        /**
         *  1.判断本地沙盒中是否存在plist
         *  2.如果存在，加载本地的数据，显示在表格中，
         *  3.判断是否联网，如果联网
         *  4.去网络加载数据
         */
        
        [self loadData1];
    }
    return _group;
}
- (void)loadData
{
    NSURL *url = [NSURL URLWithString:@"http://localhost/friends.xml"];
    
    dispatch_queue_t q = dispatch_queue_create("load data", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(q, ^{
        [NSThread sleepForTimeInterval:2.0f];
        // 网络的同步请求
        NSArray *dictArray = [NSArray arrayWithContentsOfURL:url];
        NSMutableArray *groupArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            MJFriendGroup *group = [MJFriendGroup groupWithDict:dict];
            [groupArray addObject:group];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.group = groupArray;
        });
        
    });
}

- (void)loadData1
{
    NSURL *url = [NSURL URLWithString:@"http://localhost/friends.xml"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:0.0f];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    // 建立一条新线程，连接到网络，并等待返回数据
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // data 就是从网络返回的数据
        // 数据写入沙盒(本地数据缓存，把网络数据保存在本地，避免重复联网)
        // 取得沙盒文档的路径
        NSString *cache = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cache stringByAppendingPathComponent:@"friends.plist"];
        // 写入沙盒
        [data writeToFile:path atomically:YES];
        NSLog(@"写入成功 %@", path);
        
        // 对data处理
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *groupArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            MJFriendGroup *group = [MJFriendGroup groupWithDict:dict];
            [groupArray addObject:group];
        }
        
        // 回到主线程工作
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新UI
            self.group = groupArray;
        });
    }];
    [dataTask resume];

    
}
@end
