//
//  YTXMLViewController.m
//  0112XML解析
//
//  Created by Lynn on 16/1/13.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "YTXMLViewController.h"
#import "YTBook.h"

@interface YTXMLViewController()<NSXMLParserDelegate>
@property(nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, strong) NSMutableString *elementString;
@property(nonatomic, strong) YTBook *book;

@end

@implementation YTXMLViewController

- (IBAction)loadData
{
    [super loadData];
    
    NSString *path = @"/Users/lynn/IOS_Workspace/IOS_Learning/IOS学习/0112XML解析分离/0112XML解析/test.xml";
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    // 设置代理
    parser.delegate = self;
    // 开始解析
    [parser parse];
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
    NSLog(@"解析结束 %@",self.dataList);
    for (YTBook *book in self.dataList) {
        NSLog(@"BOOK-%@",book);
    }
    
    // 网络加载数据，需要在parserDidEndDocument中，回到主线程刷新表格
    dispatch_async(dispatch_get_main_queue(), ^{
        // 在ios开发中使用一个可变对象给不可变对象赋值时，使用copy
        self.booksList = [self.dataList copy];
        [self.tableView reloadData];
        
        [self.refreshControl endRefreshing];
    });
}

#pragma mark - 出错处理
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    
    NSLog(@"出错处理-%@",parseError.localizedDescription);
}

@end
