//
//  XUStatus.h
//  0131YTWeibo
//
//  Created by Lynn on 16/2/2.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XUUser.h"
@interface XUStatus : NSObject

/**
 *  内容
 */
@property(nonatomic, copy) NSString *text;
/**
 *  微博来源
 */
@property(nonatomic, copy) NSString *source;
/**
 *  微博的ID
 */
@property(nonatomic, assign) long long ID;
/**
 *  微博的转发数
 */
@property(nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property(nonatomic, assign) int comments_count;
/**
 *  用户信息
 */
@property(nonatomic, strong) XUUser *user;

+ (instancetype)statusWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
/*
 "comments_count" = 0;
 "created_at" = "Tue Feb 02 23:37:09 +0800 2016";
 favorited = 0;
 id = 3938216438923402;
 "reposts_count" = 0;
 source = "<a href=\"http://app.weibo.com/t/feed/57v3zY\" rel=\"nofollow\">\U4e09\U661f GALAXY S6 edge</a>";
 text = "\U5076\U5c14\U5bf9\U81ea\U5df1\U597d\U4e9b\Uff0c\U5077\U4e2a\U5c0f\U61d2\Uff0c\U62bd\U70b9\U5c0f\U75af\Uff0c\U4e0d\U7b97\U4f24\U5929\U5bb3\U7406\U3002";

 user =             {

 id = 5013219702;
 name = "\U975c\U7b71\U59d0";
 "profile_image_url" = "http://tp3.sinaimg.cn/5013219702/50/5745668906/0";

*/