//
//  ViewController.m
//  0106NSOperationTest
//
//  Created by Lynn on 16/1/6.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) NSOperationQueue *myQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.myQueue = [[NSOperationQueue alloc]init];
    [self demoOp1];
//    [self demoOp2];
    
//    [self demoOp3];
}
- (void)demoOp:(id)obj
{
    NSLog(@"%@ - %@",[NSThread currentThread], obj);
}
#pragma marK - NSOperation 方法
#pragma mark 设置任务的执行顺序
- (void)demoOp3
{
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片 %@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"修饰图片 %@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"保存图片 %@",[NSThread currentThread]);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"更新UI %@",[NSThread currentThread]);
    }];
    
    // 设定执行顺序，Dependency依赖，可能会开多个，但不会太多
    // 依赖关系是可以跨队列的
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [op4 addDependency:op3];
    
    // GCD 是串行队列，异步任务，只会开一个线程
    
    [self.myQueue addOperation:op1];
    [self.myQueue addOperation:op2];
    [self.myQueue addOperation:op3];
    // 所有UI更新都在主线程上
    [[NSOperationQueue mainQueue] addOperation:op4];
    //[self.myQueue addOperation:op4];
    
}
#pragma mark NSInvocationOperation
- (void)demoOp2
{
    NSInvocationOperation *op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(demoOp:) object:@"helloOP"];
    
    //[self.myQueue addOperation:op];
    [[NSOperationQueue mainQueue] addOperation:op];
    
}

#pragma mark NSBlockOperation
- (void)demoOp1
{
    NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    // 所有自定义的队列，都是在子线程中运行
    //[self.myQueue addOperation:block];
    
    // 新建线程是有开销的
    // 在设定同时并发的最大线程数时，若果前一个线程工作完成，但是还没有销毁，就会创建新线程
    [self.myQueue setMaxConcurrentOperationCount:1];
    for (int i = 0; i<10; i++) {
        [self.myQueue addOperationWithBlock:^{
            NSLog(@"%@ = %d",[NSThread currentThread], i);
        }];
    }
    
    
    // 在主线程中执行
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
}

@end
