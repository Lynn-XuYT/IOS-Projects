//
//  DemoObj.m
//  0407单例
//
//  Created by Lynn on 16/1/7.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "DemoObj.h"

@implementation DemoObj

// IOS中所有对象的内存空间分配，最终都会调用allocWithZone
// 如果单例，就重写这个方法
// GCD提供了一个方法，专门用来创建单例的
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static DemoObj *instance;
    // dispatch_once是线程安全的，onceToken默认为0
    static dispatch_once_t onceToken;
    // dispatch_once宏可以保证代码块中的指令只被执行一次
    dispatch_once(&onceToken,^{
        //永远执行一次
        instance = [super allocWithZone:zone];
    });
    return instance;
}
+ (instancetype)shareDemoObj
{
    return [[self alloc]init];
}
@end
