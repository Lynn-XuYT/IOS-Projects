//
//  XUAccountTool.h
//  0131YTWeibo
//
//  Created by Lynn on 16/2/2.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XUAccount;
@interface XUAccountTool : NSObject

/**
 *  存储账号信息
 */
+ (void)saveAccount:(XUAccount *)account;

/**
 *  返回存储的账号信息
 */
+ (XUAccount *)account;
@end
