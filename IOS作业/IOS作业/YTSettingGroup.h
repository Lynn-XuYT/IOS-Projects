//
//  YTSettingGroup.h
//  IOS作业
//
//  Created by zhu on 15/12/25.
//  Copyright © 2015年 xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTSettingGroup : NSObject

@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *footer;

@property (nonatomic, strong) NSArray *items;
@end
