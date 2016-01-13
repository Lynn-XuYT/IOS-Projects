//
//  YTJSONViewController.m
//  0112XML解析
//
//  Created by Lynn on 16/1/13.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "YTJSONViewController.h"
#import "YTBook.h"
@implementation YTJSONViewController

- (void)loadData
{
    // 显示刷新控件
    
    // 1.url
    NSURL *url = [NSURL URLWithString:@""];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:5.0f];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 反序列化
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        // 建立数组
        NSMutableArray *arrayM = [NSMutableArray array];
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YTBook *book = [[YTBook alloc]init];
            [book setValuesForKeysWithDictionary:obj];
            [arrayM addObject:book];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.booksList = [arrayM copy];
            [self.refreshControl endRefreshing];
        }); 
    }];

}
@end
