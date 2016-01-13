//
//  MJFriendGroup.m
//  16-QQ好友列表
//
//  Created by zhu on 15/11/22.
//  Copyright © 2015年 xu. All rights reserved.
//

#import "MJFriendGroup.h"
#import "MJFriend.h"
@implementation MJFriendGroup

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        //1. 注入数据
        [self setValuesForKeysWithDictionary:dict];
        
        //2. 特殊处理Friend属性
        NSMutableArray *friendArray = [NSMutableArray array];
        for (NSDictionary *dict in self.friends) {
            MJFriend *friend = [MJFriend friendWithDict:dict];
            [friendArray addObject:friend];
        }
        self.friends = friendArray;
        
    }
    return self;
}
+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
