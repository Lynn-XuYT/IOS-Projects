//
//  MJStatusFrame.h
//  04-微博
//
//  Created by apple on 14-4-1.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  这个模型对象专门用来存放cell内部所有的子控件的frame数据  + cell的高度
// 一个cell拥有一个MJStatusFrame模型

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class YTMemo;

@interface YTMemoFrame : NSObject<NSCoding>

/**
 *  标题的frame
 */
@property (nonatomic, assign, readonly) CGRect titleF;

/**
 *  正文的frame
 */
@property (nonatomic, assign, readonly) CGRect subtitleF;
/**
 *  时间的frame
 */
@property (nonatomic, assign, readonly) CGRect timeF;

/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, strong) YTMemo *memo;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *substitle;
@property (nonatomic, copy) NSString *time;

@end
