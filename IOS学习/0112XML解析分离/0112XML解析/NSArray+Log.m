//
//  NSArray+Log.m
//  0112XML解析
//
//  Created by Lynn on 16/1/13.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

// 专门针对中文编码不正确
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    return strM;
}
@end
