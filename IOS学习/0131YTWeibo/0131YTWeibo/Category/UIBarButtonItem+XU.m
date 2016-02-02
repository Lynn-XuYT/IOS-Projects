//
//  UIBarButtonItem+XU.m
//  0131YTWeibo
//
//  Created by Lynn on 16/2/1.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "UIBarButtonItem+XU.h"

@implementation UIBarButtonItem (XU)
/**
 *  快速创建一个现实图片的item
 *
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setBackgroundImage:[UIImage imageWithNamed:icon] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageWithNamed:highIcon] forState:UIControlStateHighlighted];
    btn.bounds = CGRectMake(0, 0, btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
