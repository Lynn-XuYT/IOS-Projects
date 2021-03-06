//
//  UIImage+XU.h
//  0131YTWeibo
//
//  Created by Lynn on 16/1/31.
//  Copyright © 2016年 ZJUMSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XU)
+ (UIImage *)imageWithNamed:(NSString *)name;
/**
 *  返回一个拉伸好的图片
 */
+ (UIImage *)resizeImageWithName:(NSString *)name;
@end
