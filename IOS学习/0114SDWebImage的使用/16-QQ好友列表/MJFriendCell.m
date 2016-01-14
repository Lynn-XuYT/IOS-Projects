//
//  MJFriendCell.m
//  16-QQ好友列表
//
//  Created by zhu on 15/11/23.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "MJFriendCell.h"
#import "MJFriend.h"
#define ICONURL @"http://localhost/res/"
@interface MJFriendCell()


@end

@implementation MJFriendCell

+ (instancetype)cellWithTableview:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID = @"friend";
    MJFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MJFriendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    return cell;
}

-(void)setFriendData:(MJFriend *)friendData
{
    _friendData = friendData;
    self.detailTextLabel.text = friendData.intro;
    
    self.textLabel.textColor = (friendData.isVip ? [UIColor redColor]:[UIColor blackColor]);
    self.textLabel.text = friendData.name;
    
    //self.imageView.image = [UIImage imageNamed:friendData.icon];
   
    if (!friendData.image) {
        self.imageView.image = [UIImage imageNamed:@"default"];
        
        // 到网络加载数据
        [self loadFriendImages:friendData];
    }else{
        self.imageView.image = friendData.image;
    }
    

}

- (void)loadFriendImages:(MJFriend *)friendData
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",ICONURL,friendData.icon];
    NSLog(@"%@ indexPath= %@",urlStr,self.indexPath);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:0 timeoutInterval:2.0f];
    
    // 发送网络请求
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [NSThread sleepForTimeInterval:1.0f];
        
        // 将data转换成image
        friendData.image = [UIImage imageWithData:data];
        self.imageView.image = friendData.image;
        dispatch_async(dispatch_get_main_queue(), ^{
            // 通知controller刷新表格
            if ([self.delegateCell respondsToSelector:@selector(cell:atIndexPath:)]) {
                [self.delegateCell cell:self atIndexPath:self.indexPath];
            }
        });
    }];
    [dataTask resume];
}

@end
