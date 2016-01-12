//
//  YTBooks.h
//  0112XML解析
//
//  Created by Lynn on 16/1/12.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTBook : NSObject
@property(nonatomic, copy) NSString *bookId;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *author;
@property(nonatomic, strong) NSNumber *price;
@property(nonatomic, copy) NSString *publishHouse;
@property(nonatomic, copy) NSString *descriptions;
@end
