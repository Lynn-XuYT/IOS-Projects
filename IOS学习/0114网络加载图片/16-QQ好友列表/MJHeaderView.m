//
//  MJHeaderView.m
//  16-QQ好友列表
//
//  Created by zhu on 15/11/22.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "MJHeaderView.h"
#import "MJFriendGroup.h"

@interface MJHeaderView ()

@property (nonatomic, weak) UILabel *countView;
@property (nonatomic, weak) UIButton *nameView;
@end


@implementation MJHeaderView

-(void)setGroup:(MJFriendGroup *)group
{
    _group = group;
    
    // 设置按钮的frame
    [self.nameView setTitle:group.name forState:UIControlStateNormal];
    
    // 设置好友数的frame
    self.countView.text = [NSString stringWithFormat:@"%d/%lu",group.online,(unsigned long)group.friends.count];
    
    // 重设左边箭头状态
    [self didMoveToSuperview];
    
}

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString* ID = @"Header";
    MJHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[MJHeaderView alloc] initWithReuseIdentifier:ID];
        
    }
    return header;
}

- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        // 添加按钮
        UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 设置背景图片
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        
        // 设置按钮内部的左边箭头图片
        [nameView setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [nameView setTitle:@"我的好友" forState:UIControlStateNormal];
        
        
        nameView.imageView.contentMode = UIViewContentModeCenter;
        nameView.imageView.clipsToBounds = NO;
        // 设置按钮的内容左对齐
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        // 设置按钮的内边距
        nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        // 添加按钮点击事件
        [nameView addTarget:self action:@selector(nameViewClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:nameView];
        self.nameView = nameView;
        
        // 添加好友数
        UILabel *countView = [[UILabel alloc]init];
        countView.textColor = [UIColor grayColor];
        countView.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:countView];
        self.countView = countView;
    }
    [UIImage imageNamed:@"001"];
    return self;
}
/**
 *  监听组名的点击
 */
- (void)nameViewClick
{
    // 修改模型数据
    self.group.opened = !self.group.isOpened;
    
    // 刷新表格
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickName:)]) {
        [self.delegate headerViewDidClickName:self];
        
    }
}

-(void)didMoveToSuperview
{
    // 监听箭头的状态
    if (self.group.opened) {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    else{
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

/**
 *  系统自动调用
 *  当一个控件的frame发生改变时就会调用
 *  一般在这里布局内部的子控件（设置子控件的frame）
 */
-(void)layoutSubviews
{
#warning 一定要调用super的方法
    [super layoutSubviews];
    
    // 1. 设置按钮的frame
    self.nameView.frame = self.bounds;
    
    // 2. 设置好友数的frame
    CGFloat countY = 0;
    CGFloat countH = self.frame.size.height;
    CGFloat countW = 150;
    CGFloat padding = 10;
    CGFloat countX = self.frame.size.width - padding - countW;

    self.countView.frame = CGRectMake(countX, countY, countW, countH);
}

@end
