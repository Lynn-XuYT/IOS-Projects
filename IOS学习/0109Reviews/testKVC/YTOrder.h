//
//  YTOrder.h
//  0109Reviews
//
//  Created by Lynn on 16/1/10.
//  Copyright © 2016年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTItem.h"
@interface YTOrder : NSObject

@property(nonatomic, strong) YTItem *item;
@property(nonatomic, assign) int count;
@end
