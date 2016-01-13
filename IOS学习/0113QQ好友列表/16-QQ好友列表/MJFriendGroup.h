//
//  MJFriendGroup.h
//  16-QQ好友列表
//
//  Created by zhu on 15/11/22.
//  Copyright © 2015年 xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJFriendGroup : NSObject

@property (nonatomic,copy)NSString * name;
@property (nonatomic,assign)int online;
@property (nonatomic,strong)NSArray * friends;

/**
 *  这组是否需要展开 YES
 */
@property (nonatomic, assign, getter=isOpened) BOOL opened;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;

@end
