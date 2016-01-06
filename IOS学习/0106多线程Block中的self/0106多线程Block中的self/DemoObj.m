//
//  DemoObj.m
//  0106多线程Block中的self
//
//  Created by Lynn on 16/1/6.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "DemoObj.h"

@interface DemoObj()
@property(nonatomic, strong) NSOperationQueue *queue;
@end
@implementation DemoObj


/**
 *  如果self对象持有操作对象的引用，同时操作对象当中又直接访问了self时，才会造成循环引用
 *  单纯在操作对象中使用self不会造成循环引用
 *  此时不能使用（__weak）
 
 只有self直接强引用block，才会出现循环引用
 block的管理及线程的创建和销毁是由队列负责，在block中使用self没有关系
 */
- (void)dealloc
{
    NSLog(@" dealloc ");
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.queue = [[NSOperationQueue alloc]init];
    }
    return self;
}

- (void)demoOp:(id)obj
{
    NSLog(@"%@ == %@",[NSThread currentThread], obj);
    
}
- (void)demoBlockOp
{
    for (int i = 0; i<10; i++) {
        [self.queue addOperationWithBlock:^{
            [self demoOp:@(i)];
        }];
    }

}
@end
