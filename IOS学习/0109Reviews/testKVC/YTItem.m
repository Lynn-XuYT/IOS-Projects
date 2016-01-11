//
//  YTItem.m
//  0109Reviews
//
//  Created by Lynn on 16/1/10.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "YTItem.h"

@implementation YTItem

- (void)setNilValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"price"]) {
        _price = 0;
    }
    else
    {
        // 回调父类方法
        [super setNilValueForKey:key];
    }
}
@end
