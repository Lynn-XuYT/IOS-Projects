//
//  MJFriendCell.h
//  16-QQ好友列表
//
//  Created by zhu on 15/11/23.
//  Copyright © 2015年 xu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJFriend,MJFriendCell;

@protocol MJFriendCellDelegate <NSObject>

@optional
- (void)cell:(MJFriendCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end



@interface MJFriendCell : UITableViewCell
@property(nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong) MJFriend * friendData;
+ (instancetype)cellWithTableview:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@property(nonatomic, strong) id<MJFriendCellDelegate> delegateCell;
@end
