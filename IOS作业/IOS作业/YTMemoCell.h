//
//  YTMemoCell.h
//  IOS作业
//
//  Created by Lynn on 15/12/30.
//  Copyright © 2015年 xu. All rights
//

#import <UIKit/UIKit.h>
@class YTMemoFrame;

@interface YTMemoCell : UITableViewCell

@property (nonatomic, strong) YTMemoFrame *memoFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
