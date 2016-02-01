//
//  XUTabBarView.h
//  0131XUWeibo
//
//  Created by Lynn on 16/1/31.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XUTabBarView;
@protocol XUTabBarViewDelegate <NSObject>
@optional
- (void)tabBar:(XUTabBarView *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

@end

@interface XUTabBarView : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property(nonatomic, weak) id<XUTabBarViewDelegate> delegate;
@end
