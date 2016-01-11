//
//  ViewController.m
//  0105GCDTest
//
//  Created by Lynn on 16/1/5.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@---",[NSThread currentThread]);
    // [self gcdTest1];
    // [self gcdTest2];
    // [self gcdTest3];
    // [self gcdTest4];
    [self gcdTest5];
}

// GCD方法 串行队列 同步任务 会在 主线程 上运行
- (void)gcdTest1
{
    // 将操作放到队列中
    // 在C语言函数中，定义类型，绝大多数的结尾是_t 或ref
    dispatch_queue_t q = dispatch_queue_create("Lynn", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i<10; i++) {
        
        // 异步任务
        dispatch_async(q, ^{
            // 可以在开发中，跟踪当前线程
            NSLog(@"%@=== %d",[NSThread currentThread],i);
        });
    }

}
// GCD 方法 并行 无先后顺序
// 并行队列容易出错，并行队列不能控制新线程的数量
- (void)gcdTest2
{
    // 将操作放到队列中
    // 在C语言函数中，定义类型，绝大多数的结尾是_t 或ref
    dispatch_queue_t q = dispatch_queue_create("LynnT2", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<10; i++) {
        // 异步任务
        dispatch_async(q, ^{
            // 可以在开发中，跟踪当前线程
            NSLog(@"%@+++++ %d",[NSThread currentThread],i);
        });
    }
}

// GCD 方法 串行 同步任务
- (void)gcdTest3
{
    // 将操作放到队列中
    // 在C语言函数中，定义类型，绝大多数的结尾是_t 或ref
    dispatch_queue_t q = dispatch_queue_create("LynnT2", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i<10; i++) {
        // 同步任务
        dispatch_sync(q, ^{
            // 可以在开发中，跟踪当前线程
            NSLog(@"%@+++++ %d",[NSThread currentThread],i);
        });
    }
}

// 全局队列
- (void)gcdTest4
{
    // 全局队列 与并行队列的区别
    // 1 不需要创建，直接GET就可以使用
    // 2 两个队列的执行效果相同
    // 3 全局队列没用名称，调试时无法确认准确队列
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int i = 0; i<10; i++) {
        // 同步任务
        dispatch_sync(q, ^{
            // 可以在开发中，跟踪当前线程
            NSLog(@"%@+++++ %d",[NSThread currentThread],i);
        });
    }
    
    for (int i = 0; i<10; i++) {
        // 异步任务
        dispatch_async(q, ^{
            // 可以在开发中，跟踪当前线程
            NSLog(@"%@+++++ %d",[NSThread currentThread],i);
        });
    }
}

// 主（线程）队列 保证操作在主线程上执行
- (void)gcdTest5
{
    // 每一个应用程序都只有一个主线程
    // 在IOS开发中，所有UI的更新工作，都必须在主线程上执行
    dispatch_queue_t q = dispatch_get_main_queue();
    
    // 主线程是一直工作的，而且除非将程序杀掉，否则主线程的工作永远不会结束
    // 不能执行同步 程序，将会被阻塞
    
    
    
    for (int i = 0; i<10; i++) {
        // 异步任务
        dispatch_async(q, ^{
            // 可以在开发中，跟踪当前线程
            NSLog(@"%@+++++ %d",[NSThread currentThread],i);
        });
    }
}
@end
