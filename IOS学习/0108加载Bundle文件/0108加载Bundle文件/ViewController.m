//
//  ViewController.m
//  0108加载Bundle文件
//
//  Created by Lynn on 16/1/8.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) UIWebView *webView;
@end

@implementation ViewController

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.webView];
    [self loadFile];
    [self loadDataFile];
}

#pragma mark - 加载文件
- (void)loadFile
{
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"iOS 7 Programming Cookbook.pdf" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    
    [self.webView loadRequest:request];
}

#pragma 以二进制数据的形式加载文件
- (void)loadDataFile
{
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"iOS 7 Programming Cookbook.pdf" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    
    // 服务器的相应对象，服务器接收到请求返回给客户端的
    NSURLResponse *response = nil;
    
    // 发送请求给服务器地址 ：url(http://服务器地址/资源路径)
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    NSLog(@"%@",response.MIMEType);
    
    [self.webView loadData:data MIMEType:response.MIMEType textEncodingName:@"UTF8" baseURL:NULL];
}

- (NSString *)mimeType:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 服务器的相应对象，服务器接收到请求返回给客户端的
    NSURLResponse *response = nil;
    
    // 发送请求给服务器地址 ：url(http://服务器地址/资源路径)
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    
//    NSURLSession *session = [[NSURLSession alloc]init];
//    session dataTaskWithRequest:<#(nonnull NSURLRequest *)#> completionHandler:
    
    NSLog(@"%@",response.MIMEType);
    
    return  response.MIMEType;
}

@end
