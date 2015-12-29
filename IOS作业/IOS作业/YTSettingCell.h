//
//  YTSettingCell.h
//  IOS作业
//
//  Created by zhu on 15/12/25.
//  Copyright © 2015年 xu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTSettingItem;
@interface YTSettingCell : UITableViewCell

@property (nonatomic, strong)  YTSettingItem* item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
