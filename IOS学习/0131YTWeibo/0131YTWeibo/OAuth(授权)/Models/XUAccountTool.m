//
//  XUAccountTool.m
//  0131YTWeibo
//
//  Created by Lynn on 16/2/2.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "XUAccountTool.h"
#import "XUAccount.h"

#define XUAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
@implementation XUAccountTool

/**
 *  存储账号信息
 */
+ (void)saveAccount:(XUAccount *)account
{
    // 计算账号的过期时间
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:XUAccountFile];
}

/**
 *  返回存储的账号信息
 */
+ (XUAccount *)account
{
    // 取出账号
    XUAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:XUAccountFile];
    
    // 判断是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) {
         // 还没过期
        return account;
    }else{
        // 过期
        return nil;
    }
}

@end
