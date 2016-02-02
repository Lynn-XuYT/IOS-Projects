//
//  XUOAuthViewController.m
//  0131YTWeibo
//
//  Created by Lynn on 16/2/1.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import "XUOAuthViewController.h"
#import "AFNetworking.h"
#import "XUAccount.h"
#import "XUAccountTool.h"
#import "XUTabBarViewController.h"
#import "MBProgressHUD+MJ.h"

@interface XUOAuthViewController()<UIWebViewDelegate>

@end

@implementation XUOAuthViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加webView
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 加载授权页面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1387080466&redirect_uri=http://ios.itcast.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - UIWebView代理方法

#pragma mark - webView代理方法
/**
 *  webView开始发送请求的时候就会调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示提醒框
    [MBProgressHUD showMessage:@"加载中..."];
}

/**
 *  webView请求完毕的时候就会调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}
/**
 *  webView请求失败的时候就会调用
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

/**
 *  当webView发送一个请求之前都会调用这个方法，询问代理可不可以加载这个页面（请求）
 *
 *  @return YES : 可以加载，NO : 不可以加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 请求的URL路径
    NSString *urlStr = request.URL.absoluteString;
    
    // 查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.location != NSNotFound ) {
        // 截取code=后面的请求标记（经过用户授权成功的）
        unsigned long loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
        // 发送请求给新浪，通过code换取一个accessToken
        [self accessTokenWithCode:code];
        
    }
    return YES;
}


- (void)accessTokenWithCode:(NSString *)code
{
    // 创建请求管理类
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 返回json
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // 封装请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1387080466";
    params[@"client_secret"] = @"d93831e0087d3aeda6f954747f59f5a9";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://ios.itcast.cn";
    // 发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        // 先将字典转为模型
        XUAccount *account = [XUAccount accountWithDict:responseObject];
        
        // 存储模型数据
        [XUAccountTool saveAccount:account];
        
        // 新特性\去首页
//        [IWWeiboTool chooseRootController];
        self.view.window.rootViewController = [[XUTabBarViewController alloc]init];
        // 隐藏提醒框
        [MBProgressHUD hideHUD];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-------%@",error);
        // 隐藏提醒框
        [MBProgressHUD hideHUD];
    }];
}


























@end
