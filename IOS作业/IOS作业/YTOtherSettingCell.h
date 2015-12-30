//
//  YTOtherSettingCell.h
//  IOS作业
//
//  Created by Lynn on 15/12/29.
//  Copyright © 2015年 xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTSettingItem.h"
@interface YTOtherSettingCell : UITableViewCell
@property (nonatomic, strong)YTSettingItem *item;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
