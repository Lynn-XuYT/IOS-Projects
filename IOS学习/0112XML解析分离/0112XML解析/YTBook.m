//
//  YTBooks.m
//  0112XML解析
//
//  Created by Lynn on 16/1/12.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "YTBook.h"

@implementation YTBook

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ : %p>{bookId:%@, title:%@, author:%@, price:%@, publishHouse:%@, descriptions:%@}",[self class],self,self.bookId, self.title,self.author,self.price,self.publishHouse,self.descriptions];
}
@end
