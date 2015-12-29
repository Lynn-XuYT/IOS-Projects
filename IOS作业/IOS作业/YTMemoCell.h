//
//  YTMemoCell.h
//  IOS作业
//
//  Created by zhu on 15/12/28.
//  Copyright © 2015年 xu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTMemoFrame;

@interface YTMemoCell : UITableViewCell

@property (nonatomic, strong) YTMemoFrame *memoFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
