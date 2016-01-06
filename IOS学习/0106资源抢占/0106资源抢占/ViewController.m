//
//  ViewController.m
//  0106资源抢占
//
//  Created by Lynn on 16/1/6.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 票数
/**
 *  原子锁：多读单写
 */
@property(atomic, assign) NSInteger tickets;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tickets = 10;

}

#pragma mark - 卖票操作
/**
 *  卖票循环
 */
- (void)doSaleLoop:(NSString *)opName
{
    while (YES) {
        // 是否有票
//        @synchronized(self) {
            if (self.tickets > 0) {
                -- self.tickets;
                NSLog(@"tickets剩余：%ld , %@",(long)self.tickets, opName);
            }
            else{
                break;
            }
//        }

    }
}
#pragma mark 模拟多人卖票
- (IBAction)doSale:(id)sender
{
    self.tickets = 10;
    // 队列
    dispatch_queue_t q = dispatch_queue_create("sale", DISPATCH_QUEUE_CONCURRENT);
    
    // 添加任务
    dispatch_async(q, ^{
        [self doSaleLoop:@"OP 1"];
    });
    dispatch_async(q, ^{
        [self doSaleLoop:@"OP 2"];
    });
    
    dispatch_async(q, ^{
        [self doSaleLoop:@"OP 3"];
    });
    dispatch_async(q, ^{
        [self doSaleLoop:@"OP 4"];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
