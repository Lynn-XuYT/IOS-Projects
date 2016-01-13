//
//  main.m
//  0113Copy
//
//  Created by Lynn on 16/1/13.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTPerson.h"
void M2M()
{
    // 从一个(可变的)字符串复制到另一个(可变的)字符串，地址不一样了
    NSMutableString *strM = [NSMutableString stringWithString:@"1234"];
    NSMutableString *str1 = [strM copy];
    NSLog(@"strM p = %p , strM = %@ ", strM, strM);
    NSLog(@"str1 p = %p , str1 = %@ ", str1, str1);

}

void M2N()
{
    // 从一个(可变的)字符串复制到另一个(不可变的)字符串，地址不一样了
    NSMutableString *strM = [NSMutableString stringWithString:@"1234"];
    NSString *str1 = [strM copy];
    NSLog(@"strM p = %p , strM = %@ ", strM, strM);
    NSLog(@"str1 p = %p , str1 = %@ ", str1, str1);
    
    
    // 如果直接修改指针，是可以通过id的方式间接修改，不安全
    NSString *str2 = strM;
    NSLog(@"str2 p = %p , str2 = %@ ", str2, str2);
    
    id str3 = str2;
    NSLog(@"str3 p = %p , str3 = %@ ", str3, str3);
    [str3 appendString:@"HELLO"];
    NSLog(@"str2 p = %p , str2 = %@ ", str2, str2);
}
void N2M()
{
    // 从一个(不可变的)字符串复制到另一个(可变的)字符串，地址一样
    NSString *str1 = @"1234";
    NSMutableString *strM = [str1 copy];
    NSLog(@"strM p = %p , strM = %@ ", strM, strM);
    NSLog(@"str1 p = %p , str1 = %@ ", str1, str1);
    
    // 修改strM会报错
    //[strM appendString:@"HELLO"];
    
    // 可以使用mutableCopy复制出一个可变的字符串
    NSMutableString *strM2 = [str1 mutableCopy];
    NSLog(@"strM2 p = %p , strM2 = %@ ", strM2, strM2);
    
    [strM2 appendString:@"HELLO"];
    NSLog(@"strM2 p = %p , strM2 = %@ ", strM2, strM2);
}
void N2N()
{
    // 从一个(不可变的)字符串复制到另一个(不可变的)字符串
    // 使用copy地址一样
    // 使用mutableCopy地址不一样
    NSString *str1 = @"1234";
    NSString *str2 = [str1 copy];
    NSString *str3 = [str1 mutableCopy];
    
    NSLog(@"str1 p = %p , str1 = %@ ", str1, str1);
    NSLog(@"str2 p = %p , str2 = %@ ", str2, str2);
    NSLog(@"str3 p = %p , str3 = %@ ", str3, str3);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        YTPerson *p1 = [[YTPerson alloc]init];
        p1.name = @"zhang";
        p1.age = 12;
        
        YTPerson *p2 = [p1 copy];
        
        NSLog(@"p1: %p - %@",p1,p1);
        NSLog(@"p2: %p - %@",p2,p2);
    }
    return 0;
}
