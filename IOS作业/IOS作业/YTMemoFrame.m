//
//  MJStatusFrame.m
//  04-微博
//
//  Created by apple on 14-4-1.
//  Copyright (c) 2014年 itcast. All rights reserved.
//



#import "YTMemoFrame.h"
#import "YTMemo.h"

@implementation YTMemoFrame

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


- (void)setMemo:(YTMemo *)memo
{
    _memo = memo;
    
    // 子控件之间的间距
    CGFloat padding = 10;
    
    // 标题
    // 文字的字体
    CGSize titleSize = [self sizeWithText:self.memo.title font:YTTitleFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat titleX = padding;
    CGFloat titleY = padding;
    _titleF = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
    
    // 时间
    CGFloat timeX = titleX;
    CGFloat timeY = CGRectGetMaxY(_titleF) + padding;
    CGSize timeSize = [self sizeWithText:self.memo.time font:YTTextFont maxSize:CGSizeMake(300, MAXFLOAT)];
    _timeF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    // 正文
    CGFloat substitleX = MAX(CGRectGetMaxX(_titleF), CGRectGetMaxX(_timeF)) + titleSize.width + padding;
    CGFloat substitleY = padding + padding;//CGRectGetMaxY(_titleF) +
    CGSize substitleSize = [self sizeWithText:self.memo.substitle font:YTTextFont maxSize:CGSizeMake(300, MAXFLOAT)];
    _subtitleF = CGRectMake(substitleX, substitleY, substitleSize.width, substitleSize.height);
    
    // 设置高度
    _cellHeight = MAX(CGRectGetMaxY(_subtitleF), CGRectGetMaxY(_timeF)) + padding;
}
@end
