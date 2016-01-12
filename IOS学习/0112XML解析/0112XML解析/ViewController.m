//
//  ViewController.m
//  0112XML解析
//
//  Created by Lynn on 16/1/12.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "ViewController.h"
#import "YTBook.h"
@interface ViewController ()<NSXMLParserDelegate>
@property(nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, strong) NSMutableString *elementString;
@property(nonatomic, strong) YTBook *book;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 加载数据方法
    [self loadData];
}

- (void)loadData
{
    NSString *path = @"/Users/lynn/IOS_Learning/IOS学习/0112XML解析/0112XML解析/test.xml";
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    
    // 设置代理
    parser.delegate = self;
    
    // 开始解析
    [parser parse];
//    // URL
//    NSURL *url = [NSURL URLWithString:@"http://localhost/testXML.php"];
//    
//    // request
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10.0f];
//    
//    // 发送请求
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//    [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
//        
//        // 设置代理
//        parser.delegate = self;
//        
//        // 开始解析
//        [parser parse];
//    }];
}

#pragma mark - XML解析代理方法
#pragma mark - 开始
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"开始解析");
    // dataList
    if (!self.dataList) {
        self.dataList = [NSMutableArray array];
    }else{
        [self.dataList removeAllObjects];
    }
    
    // elementString
    if (!self.elementString) {
        self.elementString = [NSMutableString string];
    }else{
        [self.elementString setString:@""];
    }
}

#pragma mark - 开始一个节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSLog(@"开始节点-%@ %@",elementName,attributeDict);
    // 每开始一个新结点之前都要清空elementString
    // 避免上一次的结果被重复拼接
    [self.elementString setString:@""];
    
    // 如果是<book>新建对象
    if ([elementName isEqualToString:@"book"]) {
        self.book = [[YTBook alloc]init];
        self.book.bookId = attributeDict[@"bookId"];
    }
}

#pragma mark - 查找内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(nonnull NSString *)string
{
    NSLog(@"查找内容-%@",string);
    // 拼接字符串
    [self.elementString appendString:string];
}
#pragma mark - 结束节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"结束节点-%@",elementName);
    // 判断如果是<title>要复制
    if ([elementName isEqualToString:@"title"]) {
        self.book.title = self.elementString;
    }else if ([elementName isEqualToString:@"author"]) {
        self.book.author = self.elementString;
    }else if ([elementName isEqualToString:@"price"]) {
        self.book.price = [NSNumber numberWithInteger:[self.elementString integerValue]];
    }else if ([elementName isEqualToString:@"publishHouse"]) {
        self.book.publishHouse = self.elementString;
    }else if ([elementName isEqualToString:@"descriptions"]) {
        self.book.descriptions = self.elementString;
    }else if ([elementName isEqualToString:@"book"]){
        NSLog(@"一本BOOK解析结束-%@",self.book);
        [self.dataList addObject:self.book];
        
    }
}

#pragma mark - 解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"解析结束");
    for (YTBook *book in self.dataList) {
        NSLog(@"BOOK-%@",book);
    }
}

#pragma mark - 出错处理
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    
    NSLog(@"出错处理-%@",parseError.localizedDescription);
}
@end
