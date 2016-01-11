//
//  main.m
//  testKVC
//
//  Created by Lynn on 16/1/10.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTUser.h"
#import "YTItem.h"
#import "YTOrder.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 创建YTOrder对象
        YTOrder* order = [[YTOrder alloc]init];
        [order setValue:@"10" forKey:@"count"];
        
        [order setValue:[[YTItem alloc] init] forKey:@"item"];
        [order setValue:@"Lynn_Xu" forKeyPath:@"item.name"];
        
        NSLog(@"order 的 item.name 为：%@", [order valueForKeyPath:@"item.name"]);
        
        NSLog(@"order 的 count 为：%@", [order valueForKey:@"count"]);
        
        
        // 创建YTItem对象
        YTItem *item = [[YTItem alloc]init];
        [item setValue:nil forKey:@"name"];
        [item setValue:nil forKey:@"price"];
        NSLog(@"item 的 name 为：%@",[item valueForKey:@"name"]);
        NSLog(@"item 的 price 为：%@",[item valueForKey:@"price"]);
        
        // 创建YTUser对象
        YTUser *user = [[YTUser alloc]init];
        // 使用KVC方式为name属性设置属性值
        [user setValue:@"Lynn" forKey:@"name"];
        // 使用KVC方式为pass属性设置属性值
        [user setValue:@"21551071" forKey:@"pass"];
        // 使用KVC方式为birth属性设置属性值
        [user setValue:[[NSDate alloc]init] forKey:@"birth"];
        
        // 使用KVC获取YTUser对象的属性
        NSLog(@"user 的 name 为：%@", [user valueForKey:@"name"]);
        NSLog(@"user 的 pass 为：%@", [user valueForKey:@"pass"]);
        NSLog(@"user 的 birth 为：%@", [user valueForKey:@"birth"]);
    }
    return 0;
}
