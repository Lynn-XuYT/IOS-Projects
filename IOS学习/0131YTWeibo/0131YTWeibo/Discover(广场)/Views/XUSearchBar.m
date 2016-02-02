//
//  XUSearchBar.m
//  0131YTWeibo
//
//  Created by Lynn on 16/2/1.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "XUSearchBar.h"
@interface XUSearchBar()

@end

@implementation XUSearchBar

+ (instancetype)searchBar
{
    return [[self alloc]init];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景
        self.background = [UIImage resizeImageWithName:@"searchbar_textfield_background"];
        
        // 左边的放大镜
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"searchbar_textfield_search_icon"]];
        iconView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        // 字体
        self.font = [UIFont systemFontOfSize:13];
        
        // 右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 设置提醒文字
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索" attributes:attrs];
        
        // 设置键盘右下角按钮的样式
        self.returnKeyType = UIReturnKeySearch;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
    
}
@end
