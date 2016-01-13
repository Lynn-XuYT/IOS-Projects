//
//  YTPerson.h
//  0113Copy
//
//  Created by Lynn on 16/1/13.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTPerson : NSObject<NSCopying>

@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) int  age;
@end
