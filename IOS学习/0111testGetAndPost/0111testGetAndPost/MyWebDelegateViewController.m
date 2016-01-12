//
//  MyWebDelegateViewController.m
//  0111testGetAndPost
//
//  Created by Lynn on 16/1/12.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "MyWebDelegateViewController.h"

@interface MyWebDelegateViewController ()<NSURLSessionDelegate,NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *logonResult;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)loginBtn;
@end

@implementation MyWebDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loginBtn {
    
    //[self getLogin];
    [self myLogin];
}

- (void)myLogin{
    // URL
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost/loginGet.php?username=%@&password=%@&submit=login",self.username.text, self.pwd.text];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 连接
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue: [[NSOperationQueue alloc] init]];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request];
    
    [dataTask resume];
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    // 准备工作
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    
}
@end
