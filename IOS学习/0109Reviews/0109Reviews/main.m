//
//  main.m
//  0109Reviews
//
//  Created by Lynn on 16/1/9.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
        NSDate *now = [NSDate date];
        
        NSLog(@"The date is %@",now);
        double second = [now timeIntervalSince1970];
        NSLog(@"It has been %f seconds since the start of 1970",second);
        
        NSDate *later = [now dateByAddingTimeInterval:100000];
        NSLog(@"In 100000 seconds it will be %@",later);
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSUInteger day = [cal ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:now];
        NSLog(@"This is day %lu of the month",(unsigned long)day);
        
        NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
        long weekday = [componets weekday];//a就是星期几，1代表星期日，2代表星期一，后面依次
        NSLog(@"Today is %ld",weekday);
        
        
    }
    return 0;
}
