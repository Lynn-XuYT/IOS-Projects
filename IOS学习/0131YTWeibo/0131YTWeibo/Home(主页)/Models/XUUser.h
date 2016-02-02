//
//  XUUser.h
//  0131YTWeibo
//
//  Created by Lynn on 16/2/3.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XUUser : NSObject

/**
 *  用户的ID
 */
@property(nonatomic, assign) long long ID;
/**
 *  用户名
 */
@property(nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property(nonatomic, copy) NSString *profile_image_url;

+ (instancetype)userWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

/*
 user =             {
 
 id = 5013219702;
 name = "\U975c\U7b71\U59d0";
 "profile_image_url" = "http://tp3.sinaimg.cn/5013219702/50/5745668906/0";
 
 */