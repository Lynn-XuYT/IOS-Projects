//
//  ViewController.m
//  0111testGetAndPost
//
//  Created by Lynn on 16/1/11.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *logonResult;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)loginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)loginBtn {
    
    //[self getLogin];
    [self postLogin];
}

/**
 *  所有网络请求使用异步请求
 */
#pragma mark -POST登录
- (void)postLogin
{
    // URL
    NSURL *url = [NSURL URLWithString:@"http://localhost/loginPost.php"];
    // request(可以改的请求)
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 默认是get请求
    request.HTTPMethod = @"POST";
    
    // 数据体
    NSString *str = [NSString stringWithFormat:@"username=%@&password=%@&submit=login",self.username.text, self.pwd.text];
    // 将字符串转换成数据
    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 连接，异步
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            // 网络请求结束之后执行
            // 将Data转换成NSString
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"###%@",str);
            NSLog(@"NSURLSessionDataTask %@",[NSThread currentThread]);
            
            // 更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.logonResult.text = str;
                NSLog(@"mainQueue %@",[NSThread currentThread]);
            }];
        }
        
    }];
    // 使用resume方法启动任务
    [dataTask resume];
    NSLog(@"come here %@",[NSThread currentThread]);
}

#pragma mark -GET登录
- (void)getLogin
{
    // URL
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost/loginGet.php?username=%@&password=%@&submit=login",self.username.text, self.pwd.text];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Connection
//    [NSURLConnection sendAsynchronousRequest:request queue: [[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response,NSData *data,  NSError *error) {
//                // 网络请求结束之后执行
//                // 将Data转换成NSString
//                NSString *str1 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"---%@",str1);
//        NSLog(@"NSURLConnection %@",[NSThread currentThread]);
//    }];
    
    // 创建Data Task
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            // 网络请求结束之后执行
            // 将Data转换成NSString
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"###%@",str);
            NSLog(@"NSURLSessionDataTask %@",[NSThread currentThread]);
            
            // 更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.logonResult.text = str;
                NSLog(@"mainQueue %@",[NSThread currentThread]);
            }];
        }

     }];
    // 使用resume方法启动任务
    [dataTask resume];
    NSLog(@"come here %@",[NSThread currentThread]);
}

@end
