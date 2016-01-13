//
//  MJFriend.h
//  16-QQ好友列表
//
//  Created by zhu on 15/11/22.
//  Copyright © 2015年 xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJFriend : NSObject
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * icon;
@property (nonatomic,copy)NSString * intro;
@property (nonatomic,assign,getter=isVip)BOOL vip;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendWithDict:(NSDictionary *)dict;

@end