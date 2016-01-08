//
//  ViewController.m
//  0107UIWebView
//
//  Created by Lynn on 16/1/7.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchBarDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // URL定位资源，需要资源的地址
    NSURL *url = [NSURL URLWithString:@"http://m.baidu.com"];
    
    // 把URL告诉服务器，请求，从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 发送请求给服务器
    [self.webView loadRequest:request];
    
    self.webView.delegate = self;
}

- (void)loadString:(NSString *)str
{
    // URL定位资源，需要资源的地址
    NSString *urlStr = str;
    if (![urlStr hasPrefix:@"http://"]) {
        urlStr = [NSString stringWithFormat:@"http://m.baidu.com/s?word=%@",str];
    }
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 把URL告诉服务器，请求，从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 发送请求给服务器
    [self.webView loadRequest:request];
}

#pragma mark - 搜索栏代理
// 开始输入
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidBeginEditing-----%@",searchBar.text);
}
// 完成输入
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing=====%@",searchBar.text);
}
// 文本改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
     NSLog(@"textDidChange+++++%@",searchBar.text);
}
// 开始搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarSearchButtonClicked######%@",searchBar.text);
    [self loadString:searchBar.text];
    
    [self.view endEditing:YES];
}


#pragma mark - WebView代理方法
#pragma mark - 完成加载，页面链表数据会更新
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    // 根据webView的当前状态，来判断按钮的状态
    self.backBtn.enabled = webView.canGoBack;
    self.forwardBtn.enabled = webView.canGoForward;
}
@end
