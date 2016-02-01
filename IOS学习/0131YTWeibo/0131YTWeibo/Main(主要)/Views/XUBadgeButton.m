//
//  XUBadgeButton.m
//  0131XUWeibo
//
//  Created by Lynn on 16/2/1.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "XUBadgeButton.h"

@implementation XUBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.userInteractionEnabled = NO;
        self.hidden = YES;
        [self setBackgroundImage:[UIImage resizeImageWithName:@"main_badge"] forState:(UIControlStateNormal)];
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        self.hidden = NO;
        // 根据数字长短设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length >1) {
            // 文字尺寸
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 10;
        }
        
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
        // 设置数字
        [self setTitle:badgeValue forState:UIControlStateNormal];
    }else
    {
        self.hidden = YES;
    }
}
@end
