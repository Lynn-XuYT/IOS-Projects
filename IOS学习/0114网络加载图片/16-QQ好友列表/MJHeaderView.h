//
//  MJHeaderView.h
//  16-QQ好友列表
//
//  Created by zhu on 15/11/22.
//  Copyright © 2015年 xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJFriendGroup;
@class MJHeaderView;

@protocol MJHeaderViewDelegate <NSObject>

@optional
- (void)headerViewDidClickName:(MJHeaderView *)headerView;

@end

@interface MJHeaderView : UITableViewHeaderFooterView
@property (nonatomic,strong)MJFriendGroup * group;
@property (nonatomic, weak) id<MJHeaderViewDelegate> delegate;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
