//
//  MJFriendCell.m
//  16-QQ好友列表
//
//  Created by zhu on 15/11/23.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "MJFriendCell.h"
#import "MJFriend.h"
@implementation MJFriendCell

+ (instancetype)cellWithTableview:(UITableView *)tableView
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
    self.imageView.image = [UIImage imageNamed:friendData.icon];
    self.detailTextLabel.text = friendData.intro;
    
    self.textLabel.textColor = (friendData.isVip ? [UIColor redColor]:[UIColor blackColor]);
    self.textLabel.text = friendData.name;
}
@end
