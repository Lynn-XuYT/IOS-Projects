//
//  XUAccount.h
//  0131YTWeibo
//
//  Created by Lynn on 16/2/1.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//  账号模型

#import <Foundation/Foundation.h>

@interface XUAccount : NSObject<NSCoding>

@property(nonatomic, copy) NSString *access_token;
@property(nonatomic, assign) long long expires_in;
@property(nonatomic, assign) long long remind_in;
@property(nonatomic, assign) long long uid;

@property (nonatomic, strong) NSDate *expiresTime; // 账号的过期时间

+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
